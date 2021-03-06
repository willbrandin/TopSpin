//
//  TopSpinApp.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI
import ClockKit

@main
struct TopSpinApp: App {

    @StateObject private var store: AppStore
    @Environment(\.scenePhase) var scenePhase

    init() {
        let container = PersistenceController.shared
        let context = container.container.viewContext
        
        let settingsRepository = SettingsRepository(managedObjectContext: context)
        let matchRepository = MatchHistoryRepository(managedObjectContext: context)

        let workoutSession: WorkoutInteractable = WorkoutManager.shared
        let matchController = RallyMatchController(settings: .defaultMatchSettings)
        
        let environment = AppEnvironment(settingsRepository: settingsRepository,
                                         matchRepository: matchRepository,
                                         workoutSession: workoutSession,
                                         activeMatchController: matchController)
        
        self._store = StateObject(wrappedValue: AppStore(initialState: AppState(), reducer: appReducer, environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(store)
                    .onChange(of: scenePhase) { scenePhase in
                        switch scenePhase {
                        case .active:
                            print("FOREGROUND")
                        case .background:
                            print("BACKGROUND")
                        default:
                            print("\(scenePhase)")
                            break
                        }
                    }
            }
            .onAppear {
                store.send(.load)
                store.send(.observeSettings)
                store.send(.observeHistory)
            }
        }
    }
}
