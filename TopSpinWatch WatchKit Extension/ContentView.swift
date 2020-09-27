//
//  ContentView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: AppStore
    
    @State private var currentPage: Int = 2
    @State private var activeMatch: Bool = false
    
    var defaultSettings: MatchSetting {
        return store.state.settingState.defaultSetting
    }
    
    var body: some View {
        if store.state.matchIsActive {
            ActiveMatchTabContainer(currentPage: $currentPage, defaultSettings: defaultSettings)
                .onAppear {
                    currentPage = 2
                }
        } else {
            HomeTabView(currentPage: $currentPage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
