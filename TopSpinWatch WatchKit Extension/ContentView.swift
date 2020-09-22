//
//  ContentView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentPage: Int = 2
    
    @State private var activeMatch: Bool = false
    
    var body: some View {
        if activeMatch {
            TabView(selection: $currentPage) {
                MatchWorkoutView()
                    .tag(1)
                ActiveMatchView()
                    .tag(2)
            }
        } else {
            TabView(selection: $currentPage) {
                SettingsView()
                    .tag(1)
                MatchSetupView(pageIndex: $currentPage, matchActive: $activeMatch)
                    .tag(2)
                MatchHistoryList()
                    .tag(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
