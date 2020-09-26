//
//  MatchSettingsPickerView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI
import CoreData

struct MatchSettingsPickerContainer: View {
    @EnvironmentObject var settingStore: SettingStorage
    
    var body: some View {
        MatchSettingsPickerView(defaultSetting: settingStore.settings.first(where: { $0.isDefault }) ?? settingStore.settings.first!)
    }
}

struct MatchSettingsPickerView: View {
    
    @EnvironmentObject var settingStore: SettingStorage
    
    @State private var defaultSetting: MatchSetting
    @State private var isAddNewPresented: Bool = false
    
    init(defaultSetting: MatchSetting) {
        self._defaultSetting = State(wrappedValue: defaultSetting)
    }
    
    var addSettingsButtton: some View {
        Button("Add New") {
            isAddNewPresented = true
        }
        .sheet(isPresented: $isAddNewPresented) {
            NavigationView {
                MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore), onComplete: setSelected)
            }
        }
    }
    
    func listItemLink(_ name: String, isDefault: Bool, setting: MatchSetting) -> some View {
        NavigationLink(
            destination: MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore, setting: setting), onComplete: setSelected),
            label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(name)
                        
                        if isDefault {
                            Text("Default Match Settings")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
            })
    }
    
    var listView: some View {
        List {
            Section {
                ForEach(settingStore.settings) { setting in
                    listItemLink(setting.name ?? "Unknown", isDefault: setting.isDefault, setting: setting)
                }
                .onDelete { set in
                    delete(at: set)
                }
            }
            
            Section {
                #if os(watchOS)
                NavigationLink("Add New", destination: MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore), onComplete: setSelected))
                #else
                Button("Add New") {
                    isAddNewPresented = true
                }
                .sheet(isPresented: $isAddNewPresented) {
                    NavigationView {
                        MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore), onComplete: setSelected)
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
            MatchSettingsPickerContainer()
                .environmentObject(SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
        }
    }
}
