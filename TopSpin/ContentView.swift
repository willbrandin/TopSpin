//
//  ContentView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: AppStore
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var sideBarRootNavigation: some View {
        List {
            NavigationLink(destination: MatchHistoryList()) {
                Text("Match History")
            }
            
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
            }
        }
        .navigationTitle("Top Spin")
    }
    
    var body: some View {
        if horizontalSizeClass == .compact {
            
            TabView {
                NavigationView {
                    MatchHistoryList()
                }
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("History")
                }
                .environmentObject(
                    store.derived(
                        deriveState: \.matchHistory,
                        embedAction: AppAction.matchHistory
                    )
                )
               
                NavigationView{
                    SettingsView()
                }
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Settings")
                }
                .environmentObject(
                    store.derived(
                        deriveState: \.settingState,
                        embedAction: AppAction.settings
                    )
                )
            }
        } else {
            NavigationView {
                sideBarRootNavigation
                MatchHistoryList()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}
