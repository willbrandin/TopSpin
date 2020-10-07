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
    
    func scheduleBackgroundRefreshTasks() {
        
        // Get the shared extension object.
        let watchExtension = WKExtension.shared()
        
        // If there is a complication on the watch face, the app should get at least four
        // updates an hour. So calculate a target date 15 minutes in the future.
        let targetDate = Date().addingTimeInterval(15.0 * 60.0)
        
        // Schedule the background refresh task.
        watchExtension.scheduleBackgroundRefresh(withPreferredDate: targetDate, userInfo: nil) { (error) in
            
            // Check for errors.
            if let error = error {
                print("*** An background refresh error occurred: \(error.localizedDescription) ***")
                return
            }
            
            let server = CLKComplicationServer.sharedInstance()
            for complication in server.activeComplications ?? [] {
                server.reloadTimeline(for: complication)
            }
            
            print("*** Background Task Completed Successfully! ***")
        }
    }
}
