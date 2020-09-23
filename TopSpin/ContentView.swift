//
//  ContentView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var matchStorage: MatchStorage
    @ObservedObject var settingStore: SettingStorage

    var sideBarRootNavigation: some View {
        List {
            NavigationLink(destination: MatchHistoryList(matchesStore: matchStorage)) {
                Text("Match History")
            }
            
            NavigationLink(destination: SettingsView(settingStore: settingStore)) {
                Text("Settings")
            }
        }
        .navigationTitle("Top Spin")
    }
    
    var body: some View {
        if horizontalSizeClass == .compact {
            
            TabView {
                NavigationView {
                    MatchHistoryList(matchesStore: matchStorage)
                        
                }
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("History")
                }
                
                NavigationView{
                    SettingsView(settingStore: settingStore)
                }
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Settings")
                }
            }
        } else {
            NavigationView {
                sideBarRootNavigation
                MatchHistoryList(matchesStore: matchStorage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(matchStorage: MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext), settingStore: SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
            .preferredColorScheme(.dark)
    }
}
