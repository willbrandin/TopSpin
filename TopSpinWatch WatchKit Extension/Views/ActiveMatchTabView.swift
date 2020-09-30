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

struct ActiveMatchTabContainer: View {
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
        ActiveMatchTabView(currentPage: $currentPage, matchController: matchController, cancel: cancel, complete: complete)
    }
    
    func cancel() {
        print("MATCH CANCELLED")
        store.send(.workout(action: .end))
        store.send(.endMatch)
        currentPage = 2
    }
    
    func complete() {
        store.send(.workout(action: .end))

        let workoutState = store.state.workoutState
        let workout = Workout(id: UUID(), activeCalories: workoutState.activeCalories, heartRateMetrics: workoutState.heartMetrics, startDate: workoutState.startDate ?? Date(), endDate: workoutState.endDate ?? Date())
        let match = Match(id: UUID(), date: Date(), score: MatchScore(id: UUID(), playerScore: matchController.teamOneScore, opponentScore: matchController.teamTwoScore), workout: workout)

        store.send(.matchHistory(action: .add(match: match)))
        print("MATCH COMPLETE")
        store.send(.endMatch)
        currentPage = 2
    }
}

struct ActiveMatchTabView: View {
    
    @Binding var currentPage: Int
    @ObservedObject var matchController: RallyMatchController
    
    var cancel: () -> Void
    var complete: () -> Void
    
    var body: some View {
        TabView(selection: $currentPage) {
            MatchWorkoutContainerView(cancelAction: cancel)
                .tag(1)
            
            ActiveMatchView(matchController: matchController, completeAction: complete, cancelAction: cancel)
                .equatable()
                .tag(2)
        }
    }
}

struct ActiveMatchTabView_Previews: PreviewProvider {

    static var previews: some View {
        StatefulPreviewWrapper(2) {
            ActiveMatchTabView(currentPage: $0, matchController: RallyMatchController(settings: RallySettings(limit: 11, winByTwo: true, serveInterval: 2)), cancel: {}, complete: {})
                .environmentObject(AppEnvironment.mockStore)
        }
    }
}
