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
              
            MatchSetupView(startAction: start)
                .tag(2)
            MatchHistoryList()
                .tag(3)

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
        StatefulPreviewWrapper(2) {
            HomeTabView(currentPage: $0)
                .environmentObject(AppEnvironment.mockStore)
        }
    }
}
