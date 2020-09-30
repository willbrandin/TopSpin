//
//  AppEnvironment.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    let settingsRepository: SettingsRepository
    let matchRepository: MatchHistoryRepository
    let workoutSession: WorkoutManager = WorkoutManager()
}

extension AppEnvironment {
    static let mockStore = AppStore(initialState: AppState(matchHistory: MatchHistoryState(matches: [.mock]), settingState: MatchSettingState()), reducer: appReducer, environment: AppEnvironment(settingsRepository: .mock, matchRepository: .mock))
}
