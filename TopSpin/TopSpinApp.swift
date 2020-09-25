//
//  TopSpinApp.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

@main
struct TopSpinApp: App {
    
    let persistenceController: PersistenceController
    @StateObject var matchStorage: MatchStorage
    @StateObject var settingStorage: SettingStorage
    
    init() {
        self.persistenceController = PersistenceController.shared
        let managedObjectContext = PersistenceController.standardContainer.container.viewContext
        let matchStorage = MatchStorage(managedObjectContext: managedObjectContext)
        self._matchStorage = StateObject(wrappedValue: matchStorage)
        
        let settingStorage = SettingStorage(managedObjectContext: managedObjectContext)
        self._settingStorage = StateObject(wrappedValue: settingStorage)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(matchStorage: matchStorage, settingStore: settingStorage)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
