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
    var activeMatchState: ActiveMatchState = ActiveMatchState()
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
    case matchActive
    case endMatch
    case saveMatch
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action, environment)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case let .workout(action):
        return workoutReducer(&state.workoutState, action, environment)
                
    case .matchActive:
        state.matchIsActive = true
        //environment.matchController.setdefault( .default)
    
    case .saveMatch:
        print(state.workoutState)
        print(state.activeMatchState)
        break
        
    case .endMatch:
        state.matchIsActive = false
        
    case .load:
        state.settingState.settings = environment.settingsRepository.load()
        state.matchHistory.matches = environment.matchRepository.load()
        
    case .loadHistory:
        print("HISTORY DID UPDATE")
        state.matchHistory.matches = environment.matchRepository.load()
        
    case .observeHistory:
        return environment.matchRepository.repoUpdatePublisher
            .map { setting in
                return AppAction.loadHistory
            }
            .eraseToAnyPublisher()

    case .loadSettings:
        print("SETTINGS DID UPDATE")
        state.settingState.settings = environment.settingsRepository.load()

    case .observeSettings:
        return environment.settingsRepository.repoUpdatePublisher
            .map { setting in
                return AppAction.loadSettings
            }
            .eraseToAnyPublisher()
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
