//
//  MatchSettingsFormView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

class SettingFormViewModel: ObservableObject {
    
    @ObservedObject var settingStore: SettingStorage
    
    @Published var settingsName: String = ""
    @Published var scoreLimit: Int = 11
    @Published var serveInterval: Int = 2
    @Published var winByTwo: Bool = true
    @Published var trackWorkoutData: Bool = true
    @Published var setAsDefault: Bool = true
    
    private var setting: MatchSetting?
    
    init(settingStore: SettingStorage, setting: MatchSetting? = nil) {
        self.settingStore = settingStore
        self.setting = setting
        
        if let setting = setting {
            self.settingsName = setting.name ?? ""
            self.scoreLimit = Int(setting.scoreLimit)
            self.serveInterval = Int(setting.serveInterval)
            self.winByTwo = setting.isWinByTwo
            self.trackWorkoutData = setting.isTrackingWorkout
            self.setAsDefault = setting.isDefault
        }
    }
    
    func saveAction() {
        if let setting = setting {
            update(setting)
        } else {
            save()
        }
    }
    
    private func save() {
        settingStore.addNew(name: settingsName,
                            setAsDefault: setAsDefault,
                            scoreLimit: scoreLimit,
                            serveInterval: serveInterval,
                            isWinByTwo: winByTwo,
                            isTrackingWorkout: trackWorkoutData)
    }
    
    private func update(_ setting: MatchSetting) {
        settingStore.update(settings: setting,
                            name: settingsName,
                            setAsDefault: setAsDefault,
                            scoreLimit: scoreLimit,
                            serveInterval: serveInterval,
                            isWinByTwo: winByTwo,
                            isTrackingWorkout: trackWorkoutData)
    }
}

struct MatchSettingsFormView: View {
    
    @ObservedObject var viewModel: SettingFormViewModel
    
    var onComplete: (() -> Void)?
    
    init(settingStore: SettingStorage, setting: MatchSetting? = nil, onComplete: (() -> Void)? = nil) {
        self.viewModel = SettingFormViewModel(settingStore: settingStore, setting: setting)
        self.onComplete = onComplete
    }
    
    @Environment(\.presentationMode) var presentationMode
 
    @State private var isEmptyNameError: Bool = false
    
    var closeButton: some View {
        if presentationMode.wrappedValue.isPresented {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
    
    var formView: some View {
        Form {
            Section {
                TextField("My Settings", text: $viewModel.settingsName)
                Text("Give your settings a custom name.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Section {
                #if os(watchOS)
                Picker("Score Limit", selection: $viewModel.scoreLimit) {
                    Text("11").tag(11)
                    Text("21").tag(21)
                }
                                
                Picker("Serve Interval", selection: $viewModel.serveInterval) {
                    Text("2").tag(2)
                    Text("5").tag(5)
                }
                #else
                VStack {
                    Text("What are you playing up to?")
                    Picker("Score Limit", selection: $viewModel.scoreLimit) {
                        Text("11").tag(11)
                        Text("21").tag(21)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                    Text("How often will you switch servers?")
                    Picker("Serve Interval", selection: $viewModel.serveInterval) {
                        Text("2").tag(2)
                        Text("5").tag(5)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical)
                #endif
            }
            
            Section {
                Toggle("Win by Two", isOn: $viewModel.winByTwo)
                Toggle("Track Workout", isOn: $viewModel.trackWorkoutData)
                Toggle("Set as Default", isOn: $viewModel.setAsDefault)
            }
            
            Section {
                Button("Save Settings", action: onSave)
            }
            .alert(isPresented: $isEmptyNameError) {
                Alert(title: Text("Name for Match Settings cannot be empty"))
            }
        }
        .navigationTitle("Match Settings")
    }
    
    var body: some View {
        #if os(watchOS)
        formView
            .navigationTitle("New Settings")
        #else
        formView
            .navigationTitle("New Settings")
            .navigationBarItems(leading: closeButton)

        #endif
    }
    
    private func onSave() {
        guard !viewModel.settingsName.isEmpty else {
            isEmptyNameError = true
            return
        }
        
        viewModel.saveAction()
        onComplete?()
        presentationMode.wrappedValue.dismiss()
    }
}

struct MatchSettingsFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSettingsFormView(settingStore: SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
        }
    }
}
