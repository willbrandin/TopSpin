//
//  AppState.swift
//  TopSpin
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct AppState: Equatable {
    var matchHistory: MatchHistoryState = MatchHistoryState()
    var settingState: MatchSettingState = MatchSettingState()
    var workoutState: WorkoutState = WorkoutState()
    var activeMatchState: ActiveMatchState = ActiveMatchState()
    
    var matchIsActive: Bool {
        activeMatchState.isActive
    }
}

enum AppAction {
    case load
    case loadSettings
    case loadHistory
    case observeSettings
    case observeHistory
    case matchHistory(action: MatchHistoryAction)
    case settings(action: MatchSettingsAction)
    case workout(action: WorkoutAction)
    case activeMatch(action: ActiveMatchAction)
    case saveMatch
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action, environment)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case .load:
        state.settingState.settings = environment.settingsRepository?.load() ?? []
//        state.matchHistory.matches = environment.matchRepository?.load() ?? []
        
    case .loadSettings:
        print("SETTINGS DID UPDATE")
        state.settingState.settings = environment.settingsRepository?.load() ?? []
        
    case .loadHistory:
        print("HISTORY DID UPDATE")
//        state.matchHistory.matches = environment.matchRepository?.load() ?? []

    case .observeHistory:
        return environment.matchRepository?.repoUpdatePublisher
            .map { setting in
                return AppAction.loadHistory
            }
            .eraseToAnyPublisher() ?? Empty(completeImmediately: true).eraseToAnyPublisher()
        
    case .observeSettings:
        return environment.settingsRepository?.repoUpdatePublisher
            .map { setting in
                return AppAction.loadSettings
            }
            .eraseToAnyPublisher() ?? Empty(completeImmediately: true).eraseToAnyPublisher()
        
    case .workout(action: let action):
        return workoutReducer(&state.workoutState, action, environment)
        
    case .activeMatch(action: let action):
        return activeMatchReducer(&state.activeMatchState, action, environment)

    case .saveMatch:
        let score = MatchScore(id: UUID(), playerScore: state.activeMatchState.teamOneScore, opponentScore: state.activeMatchState.teamTwoScore)
        
        if let matchCorrelation = state.activeMatchState.correlationId,
           let workoutCorrelation = state.workoutState.correlationId,
           matchCorrelation == workoutCorrelation {
            let workout = Workout(id: UUID(),
                                  activeCalories: state.workoutState.activeCalories,
                                  heartRateMetrics: state.workoutState.heartMetrics,
                                  startDate: state.workoutState.startDate!,
                                  endDate: state.workoutState.endDate!)
            let match = Match(id: UUID(), date: Date(), score: score, workout: workout)
            
            state.matchHistory.matches.append(match)
            environment.matchRepository?.save(match)
        } else {
            let match = Match(id: UUID(), date: Date(), score: score, workout: nil)

            state.matchHistory.matches.append(match)
            environment.matchRepository?.save(match)
        }
        
        state.activeMatchState.correlationId = nil
        state.workoutState.correlationId = nil
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
