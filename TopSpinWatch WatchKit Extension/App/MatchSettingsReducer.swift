//
//  MatchSettingsReducer.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

enum MatchSettingsAction {
    case add(setting: MatchSetting)
    case update(setting: MatchSetting)
    case delete(setting: MatchSetting)
}

struct MatchSettingState: Equatable {
    var settings: [MatchSetting] = []
    
    var defaultSetting: MatchSetting {
        return settings.first(where: { $0.isDefault }) ?? .defaultSettings
    }
}

func settingsReducer(_ state: inout MatchSettingState, _ action: MatchSettingsAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .add(setting):
        if setting.isDefault {
            removeCurrentDefault(state: &state, environment)
        }
        
        state.settings.append(setting)
        environment.settingsRepository.save(setting)
                
    case let .update(setting):
        state.settings.removeAll(where: { $0.id == setting.id })
        
        if setting.isDefault {
            removeCurrentDefault(state: &state, environment)
        }
        
        state.settings.append(setting)
        environment.settingsRepository.update(setting)

    case let .delete(setting):
        state.settings.removeAll(where: { $0.id == setting.id })
        environment.settingsRepository.delete(setting)
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

private func removeCurrentDefault( state: inout MatchSettingState, _ environment: AppEnvironment) {
    state.settings = state.settings
        .filter({$0.isDefault})
        .map({
            var setting = $0
            setting.isDefault = false
            environment.settingsRepository.update(setting)
            return setting
        })
}
