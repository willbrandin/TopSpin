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
    case setDefault(setting: MatchSetting)
}

struct MatchSettingState: Equatable {
    var settings: [MatchSetting] = []
    
    var defaultSetting: MatchSetting {
        return settings.first(where: { $0.isDefault }) ?? .defaultSettings
    }
}

func settingsReducer(_ state: inout MatchSettingState, _ action: MatchSettingsAction) -> AnyPublisher<AppAction, Never>  {
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
        
    case let .update(setting):
        print(setting)
    case let .delete(setting):
        print(setting)
    case let .setDefault(setting):
        print(setting)
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
