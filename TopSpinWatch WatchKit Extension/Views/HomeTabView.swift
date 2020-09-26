//
//  HomeTabView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/24/20.
//

import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var workoutSession: WorkoutManager
        
    @Binding var currentPage: Int
    @Binding var activeMatch: Bool

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
            workoutSession.requestAuthorization()
            
            if workoutSession.isWorkoutActive {
                workoutSession.endWorkout()
            }
        }
    }
    
    func start() {
        print("MATCH STARTED")
        self.activeMatch = true
        self.workoutSession.startWorkout()
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static let matchStorage = MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
    static let settingStore = SettingStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
    
    static var previews: some View {
        HomeTabView(currentPage: .constant(2), activeMatch: .constant(false))
            .environmentObject(matchStorage)
            .environmentObject(settingStore)
            .environmentObject(WorkoutManager())
    }
}
