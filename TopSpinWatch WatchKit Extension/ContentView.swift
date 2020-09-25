//
//  ContentView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var matchStorage: MatchStorage
    @ObservedObject var settingStore: SettingStorage
    
    @State private var currentPage: Int = 2
    @State private var activeMatch: Bool = false
    
    var defaultSettings: MatchSetting {
        return settingStore.settings.first(where: { $0.isDefault })!
    }
    
    var body: some View {
        if activeMatch {
            ActiveMatchTabView(activeMatch: $activeMatch, currentPage: $currentPage, matchSettings: defaultSettings)
                .onAppear {
                    currentPage = 2
                }
        } else {
            HomeTabView(matchStorage: matchStorage, settingStore: settingStore, currentPage: $currentPage, activeMatch: $activeMatch)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let matchStorage = MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
    static let settingStore = SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
    
    static var previews: some View {
        ContentView(matchStorage: matchStorage, settingStore: settingStore)
    }
}
