//
//  AppStore.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct AppState: Equatable {
    var matchIsActive: Bool = false
    var matchHistory: MatchHistoryState = MatchHistoryState()
    var settingState: MatchSettingState = MatchSettingState()
    var workoutState: WorkoutState = WorkoutState()
}

enum AppAction {
    case matchHistory(action: MatchHistoryAction)
    case settings(action: MatchSettingsAction)
    case workout(action: WorkoutAction)
    case matchActive
    case endMatch
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case let .workout(action):
        return workoutReducer(&state.workoutState, action, environment)
                
    case .matchActive:
        state.matchIsActive = true
        
    case .endMatch:
        state.matchIsActive = false
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
