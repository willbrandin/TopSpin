//
//  MatchSettingsFormView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSettingsFormView: View {
    
    @ObservedObject var viewModel: SettingFormViewModel
    
    var onComplete: (() -> Void)?
    
    init(viewModel: SettingFormViewModel, onComplete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onComplete = onComplete
    }
    
    @Environment(\.presentationMode) var presentationMode
 
    @State private var isEmptyNameError: Bool = false
    
    var closeButton: some View {
        if !presentationMode.wrappedValue.isPresented {
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
    
    static let viewModel = SettingFormViewModel(settingStore: SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
    
    static var previews: some View {
        NavigationView {
            MatchSettingsFormView(viewModel: viewModel)
        }
    }
}
