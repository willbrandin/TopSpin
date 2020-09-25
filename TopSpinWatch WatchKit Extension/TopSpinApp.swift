//
//  TopSpinApp.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

@main
struct TopSpinApp: App {
    
    let persistenceController: PersistenceController
    @StateObject var matchStorage: MatchStorage
    @StateObject var settingStorage: SettingStorage
    @StateObject var workoutManager: WorkoutManager
    
    init() {
        self.persistenceController = PersistenceController.shared
        let managedObjectContext = persistenceController.container.viewContext
        
        let matchStorage = MatchStorage(managedObjectContext: managedObjectContext)
        self._matchStorage = StateObject(wrappedValue: matchStorage)
        
        let settingStorage = SettingStorage(managedObjectContext: managedObjectContext)
        self._settingStorage = StateObject(wrappedValue: settingStorage)
        
        self._workoutManager = StateObject(wrappedValue: WorkoutManager())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(matchStorage: matchStorage, settingStore: settingStorage)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(matchStorage)
                    .environmentObject(workoutManager)
            }
        }
    }
}
