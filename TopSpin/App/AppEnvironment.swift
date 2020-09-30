//
//  AppEnvironment.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    let settingsRepository: SettingsRepository
}

extension AppEnvironment {
    static let mockStore = AppStore(initialState: AppState(matchHistory: MatchHistoryState(matches: [.mock]), settingState: MatchSettingState()), reducer: appReducer, environment: AppEnvironment(settingsRepository: .mock))
}
