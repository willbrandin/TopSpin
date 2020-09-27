//
//  HomeTabView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/24/20.
//

import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var store: AppStore
        
    @Binding var currentPage: Int

    var body: some View {
        TabView(selection: $currentPage) {
            SettingsView()
                .tag(1)
                .environmentObject(
                    store.derived(
                        deriveState: \.settingState,
                        embedAction: AppAction.settings)
                )
            MatchSetupView(startAction: start)
                .tag(2)
            MatchHistoryList()
                .tag(3)
                .environmentObject(
                    store.derived(
                        deriveState: \.matchHistory,
                        embedAction: AppAction.matchHistory)
                )
        }
        .onAppear {
            store.send(.workout(action: .requestPermissions))
        }
    }
    
    func start() {
        print("MATCH STARTED")
        store.send(.matchActive)
        store.send(.workout(action: .start))
    }
}

struct HomeTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeTabView(currentPage: .constant(2))
    }
}
