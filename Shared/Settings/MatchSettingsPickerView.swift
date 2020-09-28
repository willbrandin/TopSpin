//
//  MatchSettingsPickerView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI
import CoreData

struct MatchSettingsPickerContainer: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        MatchSettingsPickerView(settings: store.state.settingState.settings)
    }
}

struct MatchSettingsPickerView: View {
    
    @EnvironmentObject var store: AppStore
    
    var settings: [MatchSetting]
    
    @State private var isAddNewPresented: Bool = false
    
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
            destination: MatchSettingsFormView(setting: setting).environmentObject(store),
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
            if !settings.isEmpty {
                Section(header: Text("Custom Settings")) {
                    ForEach(settings) { setting in
                        listItemLink(setting.name, isDefault: setting.isDefault, setting: setting)
                    }
                }
            }
            
            Section(header: Text("Standard Settings")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(MatchSetting.defaultSettings.name)
                        
                        Text("Standard to 11")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
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
}

struct MatchSettingsPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSettingsPickerContainer()
        }
    }
}
