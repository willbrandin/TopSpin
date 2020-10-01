//
//  AppExtension+Mock.swift
//  TopSpin
//
//  Created by Will Brandin on 10/1/20.
//

import Foundation

extension AppEnvironment {
    static let mockStore = AppStore(initialState: AppState(matchHistory: MatchHistoryState(matches: [.mock]),
                                                           settingState: MatchSettingState()), reducer: appReducer,
                                    environment: AppEnvironment(settingsRepository: .mock,
                                                                matchRepository: .mock,
                                                                workoutSession: nil, activeMatchController: nil))
}
