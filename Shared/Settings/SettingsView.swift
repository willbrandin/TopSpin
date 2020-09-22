//
//  SettingsView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedSettings: Int = 0
    
    var listView: some View {
        List {
            Section(header: Text("Match Settings")) {
                Picker("Default Settings", selection: $selectedSettings) {
                    Text("My Default").tag(0)
                    Text("Just for fun").tag(1)
                }
                
                NavigationLink(destination: MatchSettingsFormView()) {
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
