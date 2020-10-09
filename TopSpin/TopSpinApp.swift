//
//  TopSpinApp.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI
import StoreKit

@main
struct TopSpinApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var store: AppStore
    
    init() {
        let container = PersistenceController.shared
        let context = container.container.viewContext
        
        let settingsRepository = SettingsRepository(managedObjectContext: context)
        let matchRepository = MatchHistoryRepository(managedObjectContext: context)
        
        let environment = AppEnvironment(settingsRepository: settingsRepository,
                                         matchRepository: matchRepository,
                                         workoutSession: nil,
                                         activeMatchController: nil)
        
        self._store = StateObject(wrappedValue: AppStore(initialState: AppState(), reducer: appReducer, environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .onAppear {
                    store.send(.load)
                    store.send(.observeSettings)
                    store.send(.observeHistory)
                    setLaunchCount()
                }
                .onChange(of: scenePhase) { scenePhase in
                    switch scenePhase {
                    case .active:
                        print("FOREGROUND")
                        setLaunchCount()
                        
                    case .background:
                        print("BACKGROUND")
                        
                    default:
                        print("\(scenePhase)")
                        break
                    }
                }
        }
    }
    
    func setLaunchCount() {
        LaunchCounter().launch()
                
        if let windowScene = UIApplication.shared.windows.first?.windowScene, LaunchCounter().isReadyToRate {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

