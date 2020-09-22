//
//  ContentView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                MatchHistoryList()
                    
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("History")
            }
            
            Text("other screen")
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
