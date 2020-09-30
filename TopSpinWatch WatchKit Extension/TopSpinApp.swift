//
//  TopSpinApp.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

@main
struct TopSpinApp: App {

    @StateObject private var store: AppStore
    
    init() {
        let container = PersistenceController.shared
        let context = container.container.viewContext
        
        let settingsRepository = SettingsRepository(managedObjectContext: context)

        let environment = AppEnvironment(settingsRepository: settingsRepository)
        self._store = StateObject(wrappedValue: AppStore(initialState: AppState(), reducer: appReducer, environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(store)
            }
        }
    }
}
