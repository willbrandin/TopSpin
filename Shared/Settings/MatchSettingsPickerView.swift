//
//  MatchSettingsPickerView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI
import CoreData

struct MatchSettingsPickerContainer: View {
    @EnvironmentObject var store: Store<MatchSettingState, MatchSettingsAction>

    var body: some View {
        MatchSettingsPickerView(defaultSetting: store.state.defaultSetting)
    }
}

struct MatchSettingsPickerView: View {
    
    @EnvironmentObject var store: Store<MatchSettingState, MatchSettingsAction>

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
                MatchSettingsFormView()
            }
        }
    }
    
    func listItemLink(_ name: String, isDefault: Bool, setting: MatchSetting) -> some View {
        NavigationLink(
            destination: MatchSettingsFormView(setting: setting),
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
                ForEach(store.state.settings) { setting in
                    listItemLink(setting.name, isDefault: setting.isDefault, setting: setting)
                }
                .onDelete { set in
                    delete(at: set)
                }
            }
            
            Section {
                #if os(watchOS)
                NavigationLink("Add New", destination: MatchSettingsFormView())
                #else
                Button("Add New") {
                    isAddNewPresented = true
                }
                .sheet(isPresented: $isAddNewPresented) {
                    NavigationView {
                        MatchSettingsFormView()
                    }
                }
                #endif
            }
        }
        .onAppear {
            setSelected()
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
        defaultSetting = store.state.defaultSetting
    }
    
    private func delete(at offsets: IndexSet) {
//        let settings = offsets.map { settingStore.settings[$0] }
//        settingStore.delete(settings)
        
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
