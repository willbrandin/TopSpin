//
//  SettingsView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingStore: SettingStorage
    @State private var selectedSettings: MatchSetting
    
    init(settingStore: SettingStorage) {
        self.settingStore = settingStore
        
        self._selectedSettings = State(wrappedValue: settingStore.settings.first(where: { $0.isDefault }) ?? settingStore.settings.first!)
    }
    
    var pickerView: some View {
        Picker("Default Settings", selection: $selectedSettings) {
            ForEach(settingStore.settings) { setting in
                if let name = setting.name {
                    VStack {
                        Text(name)
                    }
                    .tag(setting)
                }
            }
        }
    }
    
    var listView: some View {
        List {
            Section(header: Text("Match Settings")) {
                pickerView
                .onChange(of: selectedSettings) { setting in
                    settingStore.setDefault(setting)
                }
                
                NavigationLink(destination: MatchSettingsFormView(settingStore: settingStore, onComplete: setSelected)) {
                    Text("Add New")
                }
            }
            
            Section(header: Text("About")) {
                Text("Version 1.0")
            }
        }
    }
    
    var body: some View {
        #if os(watchOS)
        listView
            .navigationTitle("Settings")
        #else
        listView
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
        #endif
        
    }
    
    private func setSelected() {
        selectedSettings = settingStore.settings.first(where: { $0.isDefault })!
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(settingStore: SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
        }
    }
}
