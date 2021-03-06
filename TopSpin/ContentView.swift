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
            NavigationLink(destination: MatchHistoryContainer()) {
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
                    MatchHistoryContainer()
                }
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("History")
                }
               
                NavigationView{
                    SettingsView()
                }
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Settings")
                }
            }
        } else {
            NavigationView {
                sideBarRootNavigation
                MatchHistoryContainer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.horizontalSizeClass, .compact)
            .environmentObject(AppEnvironment.mockStore)
    }
}
