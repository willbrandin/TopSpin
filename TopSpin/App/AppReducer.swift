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
    case loadFromRepo
    case listenForDataChange
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
        
    case .loadFromRepo:
        print("REPO DID UPDATE")
        state.settingState.settings = environment.settingsRepository.load()

    case .listenForDataChange:
        return environment.settingsRepository.repoUpdatePublisher
            .map { setting in
                return AppAction.loadFromRepo
            }
            .eraseToAnyPublisher()
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
