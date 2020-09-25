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
    
    @State private var isAddNewPresented: Bool = false
    
    init(settingStore: SettingStorage) {
        self.settingStore = settingStore
        
        self._selectedSettings = State(wrappedValue: settingStore.settings.first(where: { $0.isDefault }) ?? settingStore.settings.first!)
    }
    
    var pickerView: some View {
        NavigationLink(
            destination: MatchSettingsPickerView(settingStore: settingStore),
            label: {
                Text("Match Settings")
            })
    }
    
    var listView: some View {
        List {
            Section(header: Text("Match Settings")) {
                pickerView
                .onChange(of: selectedSettings) { setting in
                    settingStore.setDefault(setting)
                }
                
                #if os(watchOS)
                NavigationLink("Add New", destination: MatchSettingsFormView(settingStore: settingStore, onComplete: setSelected))
                #else
                Button("Add New") {
                    
                    isAddNewPresented = true
                }
                .sheet(isPresented: $isAddNewPresented) {
                    NavigationView {
                        MatchSettingsFormView(settingStore: settingStore, onComplete: setSelected)
                    }
                }
                #endif
                
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
