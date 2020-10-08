//
//  SettingsView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: AppStore
    
    @State private var isAddNewPresented: Bool = false
    @State private var isShowingShare: Bool = false
    
    var pickerView: some View {
        NavigationLink(
            destination: MatchSettingsPickerContainer().environmentObject(self.store),
            label: {
                Text("Match Settings")
            })
    }
    
    var shareLink: String {
        let link = "https://apps.apple.com/us/app/id1534058819"
        return "Check this out! Think you can take me? \(link)"
    }
    
    var listView: some View {
        List {
            Section(header: Text("Match Settings")) {
                pickerView
                
                #if os(watchOS)
                NavigationLink("Add New", destination: MatchSettingsFormView().environmentObject(self.store))
                #else
                Button("Add New") {
                    isAddNewPresented = true
                }
                .sheet(isPresented: $isAddNewPresented) {
                    NavigationView {
                        MatchSettingsFormView()
                    }
                    .environmentObject(self.store)
                }
                #endif
                
            }
            
            Section(header: Text("About")) {
                Text("Version 1.0")
                
                Button("Share") {
                    self.isShowingShare = true
                }
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
            .sheet(isPresented: $isShowingShare) {
                ShareSheet(sharing: [shareLink])
            }
        #endif
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(AppEnvironment.mockStore)
    }
}
