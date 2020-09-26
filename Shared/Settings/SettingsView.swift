//
//  SettingsView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingStore: SettingStorage
    
    @State private var isAddNewPresented: Bool = false
    
    var pickerView: some View {
        NavigationLink(
            destination: MatchSettingsPickerContainer(),
            label: {
                Text("Match Settings")
            })
    }
    
    var listView: some View {
        List {
            Section(header: Text("Match Settings")) {
                pickerView
                
                #if os(watchOS)
                NavigationLink("Add New", destination: MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore), onComplete: {}))
                #else
                Button("Add New") {
                    isAddNewPresented = true
                }
                .sheet(isPresented: $isAddNewPresented) {
                    NavigationView {
                        MatchSettingsFormView(viewModel: SettingFormViewModel(settingStore: settingStore), onComplete: {})
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

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
