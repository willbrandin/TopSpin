//
//  MatchSettingsFormView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSettingsFormView: View {
    
    @ObservedObject var settingStore: SettingStorage
    var onComplete: (() -> Void)?
    
    init(settingStore: SettingStorage, onComplete: (() -> Void)? = nil) {
        self.settingStore = settingStore
        self.onComplete = onComplete
    }
    
    @Environment(\.presentationMode) var presentationMode
 
    @State private var settingsName: String = ""
    @State private var scoreLimit: Int = 11
    @State private var serveInterval: Int = 2
    @State private var winByTwo: Bool = true
    @State private var trackWorkoutData: Bool = true
    @State private var setAsDefault: Bool = true
    
    var body: some View {
        Form {
            Section {
                TextField("My Settings", text: $settingsName)
                Text("Give your settings a custom name.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Section {
                #if os(watchOS)
                Picker("Score Limit", selection: $scoreLimit) {
                    Text("11").tag(11)
                    Text("21").tag(21)
                }
                                
                Picker("Serve Interval", selection: $serveInterval) {
                    Text("2").tag(2)
                    Text("5").tag(5)
                }
                #else
                VStack {
                    Text("What are you playing up to?")
                    Picker("Score Limit", selection: $scoreLimit) {
                        Text("11").tag(11)
                        Text("21").tag(21)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("How often will you switch servers?")
                    Picker("Serve Interval", selection: $serveInterval) {
                        Text("2").tag(2)
                        Text("5").tag(5)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical)
                #endif
                            
                Toggle("Win by Two", isOn: $winByTwo)
                Toggle("Track Workout", isOn: $trackWorkoutData)
                Toggle("Set as Default", isOn: $setAsDefault)
            }
            
            Section {
                Button("Save Settings", action: onSave)
            }
        }
        .navigationTitle("Match Settings")
    }
    
    private func onSave() {
        settingStore.addNew(name: self.settingsName,
                            setAsDefault: self.setAsDefault)
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

#if os(macOS)
extension View {
    func navigationBarTitle(_ title: String) -> some View {
        self
    }
    
    func navigationTitle(_ title: String) -> some View {
        self
    }
}
#endif
