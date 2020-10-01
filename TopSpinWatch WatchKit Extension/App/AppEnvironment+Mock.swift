//
//  AppEnvironment.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

extension AppEnvironment {
    static let mockStore = AppStore(initialState: AppState(matchHistory: MatchHistoryState(matches: [.mock]),
                                                           settingState: MatchSettingState()),
                                    reducer: appReducer,
                                    environment: AppEnvironment(settingsRepository: nil,
                                                                matchRepository: nil,
                                                                workoutSession: WorkoutManager.shared,
                                                                activeMatchController: RallyMatchController(settings: .defaultMatchSettings)))
}
