//
//  ActiveMatchTabView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/24/20.
//

import SwiftUI

struct RallySettings: RallyMatchConfigurable {
    let limit: Int
    let winByTwo: Bool
    let serveInterval: Int
}

struct ActiveMatchTabView: View {
    
    @Binding var activeMatch: Bool
    @Binding var currentPage: Int
    
    @EnvironmentObject var matchStorage: MatchStorage
    @EnvironmentObject var workoutSession: WorkoutManager
    
    @StateObject private var matchController: RallyMatchController
    
    init(activeMatch: Binding<Bool>, currentPage: Binding<Int>, matchSettings: RallySettings) {
        self._activeMatch = activeMatch
        self._currentPage = currentPage
        
        self._matchController = StateObject(wrappedValue: RallyMatchController(settings: matchSettings))
    }
    
    var body: some View {
        TabView(selection: $currentPage) {
            MatchWorkoutView(cancelAction: cancel)
                .tag(1)
            ActiveMatchView(completeAction: complete, cancelAction: cancel)
                .equatable()
                .environmentObject(matchController)
                .tag(2)
        }
    }
    
    func cancel() {
        print("MATCH CANCELLED")
        self.activeMatch = false
        currentPage = 2
    }
    
    func complete() {
        let workout = MatchWorkout(id: UUID(),
                                   activeCalories: Int(workoutSession.activeCalories),
                                   endDate: workoutSession.workoutEndDate ?? Date(),
                                   startDate: workoutSession.workoutStart ?? Date(),
                                   maxHeartRate: Int(workoutSession.maxHeartRate),
                                   minHeartRate: Int(workoutSession.minHeartRate),
                                   avgHeartRate: Int(workoutSession.avgHeartRate))
        
        let match = CompleteMatch(id: UUID(), opponentScore: matchController.teamTwoScore, playerScore: matchController.teamOneScore, date: Date(), workout: workout)
        
        matchStorage.addNew(match)
        
        print("MATCH COMPLETE")
        self.activeMatch = false
        currentPage = 2
    }
}

struct ActiveMatchTabView_Previews: PreviewProvider {
    
    static let context = PersistenceController.standardContainer.container.viewContext
    
    static var matchSettings: RallySettings {
        return RallySettings(limit: 11, winByTwo: true, serveInterval: 2)
    }
    
    static var previews: some View {
        StatefulPreviewWrapper(2) {
            ActiveMatchTabView(activeMatch: .constant(true), currentPage: $0, matchSettings: matchSettings)
        }
        .environmentObject(WorkoutManager())
    }
}
