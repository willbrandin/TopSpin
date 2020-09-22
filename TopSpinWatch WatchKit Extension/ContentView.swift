//
//  ContentView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentPage: Int = 2
    
    var body: some View {
        TabView(selection: $currentPage) {
            Text("Settings")
                .tag(1)
            Text("Start Match")
                .tag(2)
            MatchHistoryList()
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
