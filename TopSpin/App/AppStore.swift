//
//  AppState.swift
//  TopSpin
//
//  Created by Will Brandin on 9/29/20.
//

import Combine

struct AppState: Equatable {
    var matchHistory: MatchHistoryState = MatchHistoryState()
    var settingState: MatchSettingState = MatchSettingState()
}

enum AppAction {
    case load
    case loadSettings
    case loadHistory
    case observeSettings
    case observeHistory
    case matchHistory(action: MatchHistoryAction)
    case settings(action: MatchSettingsAction)
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action, environment)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case .load:
        state.settingState.settings = environment.settingsRepository.load()
        state.matchHistory.matches = environment.matchRepository.load()
        
    case .loadSettings:
        print("SETTINGS DID UPDATE")
        state.settingState.settings = environment.settingsRepository.load()
        
    case .loadHistory:
        print("HISTORY DID UPDATE")
        state.matchHistory.matches = environment.matchRepository.load()

    case .observeHistory:
        return environment.matchRepository.repoUpdatePublisher
            .map { setting in
                return AppAction.loadHistory
            }
            .eraseToAnyPublisher()
        
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
