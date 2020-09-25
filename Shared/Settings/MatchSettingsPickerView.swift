//
//  MatchSettingsPickerView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI
import CoreData

struct MatchSettingsPickerView: View {
    
    @ObservedObject var settingStore: SettingStorage
    @State private var defaultSetting: MatchSetting
    
    @State private var isAddNewPresented: Bool = false
    
    init(settingStore: SettingStorage) {
        self.settingStore = settingStore
        
        self._defaultSetting = State(wrappedValue: settingStore.settings.first(where: { $0.isDefault }) ?? settingStore.settings.first!)
    }
    
    var addSettingsButtton: some View {
        Button("Add New") {
            isAddNewPresented = true
        }
        .sheet(isPresented: $isAddNewPresented) {
            NavigationView {
                MatchSettingsFormView(settingStore: settingStore, onComplete: setSelected)
            }
        }
    }
    
    var listView: some View {
        List {
            Section {
                ForEach(settingStore.settings) { setting in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(setting.name ?? "Unknown")
                            
                            if setting.id! == defaultSetting.id! {
                                Text("Default Match Settings")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .onDelete { set in
                    delete(at: set)
                }
            }
            
            Section {
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
        }
    }
    
    var body: some View {
        #if os(watchOS)
        listView
            .navigationTitle("Settings")
        #else
        listView
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Match Settings")
            .navigationBarItems(trailing: EditButton())

        #endif
    }
    
    private func setSelected() {
        defaultSetting = settingStore.settings.first(where: { $0.isDefault })!
    }
    
    private func delete(at offsets: IndexSet) {
        let settings = offsets.map { settingStore.settings[$0] }
        settingStore.delete(settings)
        
        setSelected()
    }
}

struct MatchSettingsPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSettingsPickerView(settingStore: SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
        }
    }
}
