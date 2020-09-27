//
//  AppEnvironment.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    // COntext here??
    let settingsRepository = SettingsRepository()
}

struct AppState: Equatable {
    var matchHistory: MatchHistoryState = MatchHistoryState()
    var settingState: MatchSettingState = MatchSettingState()
}

struct MatchHistoryState: Equatable {
    var matches: [Match] = [.mock]
}

enum AppAction {
    case load
    case matchHistory(action: MatchHistoryAction)
    case settings(action: MatchSettingsAction)
}

enum MatchHistoryAction {
    case delete(match: Match)
}

enum MatchSettingsAction {
    case add(setting: MatchSetting)
    case update(setting: MatchSetting)
    case delete(setting: MatchSetting)
    case setDefault(setting: MatchSetting)
}

struct MatchSettingState: Equatable {
    var settings: [MatchSetting] = []
    
    var defaultSetting: MatchSetting {
        return settings.first(where: { $0.isDefault }) ?? settings.first!
    }
}

private func historyReducer(_ state: inout MatchHistoryState, _ action: MatchHistoryAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .delete(match):
        state.matches.removeAll(where: { $0.id == match.id })
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

private func settingsReducer(_ state: inout MatchSettingState, _ action: MatchSettingsAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .add(setting):
        if setting.isDefault {
            state.settings = state.settings.map({
                var setting = $0
                setting.isDefault = false
                return setting
            })
        }
        
        state.settings.append(setting)
        environment.settingsRepository.save(state.settings)
        
    case let .update(setting):
        print(setting)

    case let .delete(setting):
        print(setting)

    case let .setDefault(setting):
        print(setting)
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action, environment)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case .load:
        state.settingState.settings = environment.settingsRepository.load()
    
        // Listen to Repo changes.
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>