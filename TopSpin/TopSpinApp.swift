//
//  TopSpinApp.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

@main
struct TopSpinApp: App {

    @StateObject private var store: AppStore
    
    init() {
        let environment = AppEnvironment()
        self._store = StateObject(wrappedValue: AppStore(initialState: AppState(), reducer: appReducer, environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
