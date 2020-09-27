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
    
    @EnvironmentObject var store: AppStore
    
    @Binding var currentPage: Int
    @StateObject private var matchController: RallyMatchController
    
    init(currentPage: Binding<Int>, defaultSettings: MatchSetting) {
        self._currentPage = currentPage
        let matchSettings = RallySettings(limit: defaultSettings.scoreLimit.rawValue,
                                          winByTwo: defaultSettings.isWinByTwo,
                                          serveInterval: defaultSettings.serveInterval.rawValue)
        
        self._matchController = StateObject(wrappedValue: RallyMatchController(settings: matchSettings))
    }
    
    var body: some View {
        TabView(selection: $currentPage) {
            MatchWorkoutContainerView(cancelAction: cancel)
                .tag(1)
            
            ActiveMatchView(completeAction: complete, cancelAction: cancel)
                .environmentObject(matchController)
                .tag(2)
        }
        
    }
    
    func cancel() {
        print("MATCH CANCELLED")
        store.send(.endMatch)
        currentPage = 2
    }
    
    func complete() {
//        let workout = MatchWorkout(id: UUID(),
//                                   activeCalories: workoutSession.activeCalories,
//                                   endDate: workoutSession.workoutEndDate ?? Date(),
//                                   startDate: workoutSession.workoutStart ?? Date(),
//                                   maxHeartRate: workoutSession.maxHeartRate),
//                                   minHeartRate: Int(workoutSession.minHeartRate),
//                                   avgHeartRate: Int(workoutSession.avgHeartRate))
//
//        let match = CompleteMatch(id: UUID(), opponentScore: matchController.teamTwoScore, playerScore: matchController.teamOneScore, date: Date(), workout: workout)
        
        print("MATCH COMPLETE")
        store.send(.endMatch)
        currentPage = 2
    }
}

struct ActiveMatchTabView_Previews: PreviewProvider {
        
    static var previews: some View {
        StatefulPreviewWrapper(2) {
            ActiveMatchTabView(currentPage: $0, defaultSettings: .defaultSettings)
        }
    }
}
