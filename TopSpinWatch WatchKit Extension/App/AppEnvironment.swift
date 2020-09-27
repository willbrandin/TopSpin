//
//  AppEnvironment.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    let workoutSession = WorkoutManager.shared
}

struct AppState: Equatable {
    var matchIsActive: Bool = false
    var matchHistory: MatchHistoryState = MatchHistoryState()
    var settingState: MatchSettingState = MatchSettingState()
    var workoutState: WorkoutState = WorkoutState()
}

enum AppAction {
    case matchHistory(action: MatchHistoryAction)
    case settings(action: MatchSettingsAction)
    case workout(action: WorkoutAction)
    case activateMatch
    case endMatch
    case requestPermissions
}

struct MatchHistoryState: Equatable {
    var matches: [Match] = [.mock]
}

enum MatchHistoryAction {
    case add(match: Match)
}

enum MatchSettingsAction {
    case add(setting: MatchSetting)
    case update(setting: MatchSetting)
    case delete(setting: MatchSetting)
    case setDefault(setting: MatchSetting)
}

struct MatchSettingState: Equatable {
    var settings: [MatchSetting] = [.defaultSettings,
                                    MatchSetting(id: UUID(), createdDate: Date(), isDefault: false, isTrackingWorkout: true, isWinByTwo: true, name: "21", scoreLimit: .twentyOne, serveInterval: .everyFive)
    ]
    
    var defaultSetting: MatchSetting {
        return settings.first(where: { $0.isDefault }) ?? settings.first!
    }
}

struct WorkoutState: Equatable {
    var heartMetrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
    var heartRate = 0
    var activeCalories = 0
    var elapsedSeconds = 0
}

enum WorkoutAction {
    case setHeartMetrics(metrics: WorkoutHeartMetric)
    case setHeartRate(rate: Int)
    case setCalories(calories: Int)
    case setElapsedTime(time: Int)
    case pause
}

private func workoutReducer(_ state: inout WorkoutState, _ action: WorkoutAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .setHeartRate(rate):
        state.heartRate = rate
        
    case let .setHeartMetrics(metrics):
        state.heartMetrics = metrics
        
    case let .setCalories(calories):
        state.activeCalories = calories
        
    case let .setElapsedTime(time):
        state.elapsedSeconds = time
        
    case .pause:
        environment.workoutSession.pauseWorkout()
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

private func historyReducer(_ state: inout MatchHistoryState, _ action: MatchHistoryAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .add(match):
        state.matches.append(match)
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

private func settingsReducer(_ state: inout MatchSettingState, _ action: MatchSettingsAction) -> AnyPublisher<AppAction, Never>  {
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

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action {
    case let .settings(action):
        return settingsReducer(&state.settingState, action)
        
    case let .matchHistory(action):
        return historyReducer(&state.matchHistory, action, environment)
        
    case let .workout(action):
        return workoutReducer(&state.workoutState, action, environment)
        
    case .requestPermissions:
        environment.workoutSession.requestAuthorization()
        
    case .activateMatch:
        environment.workoutSession.startWorkout()
        state.matchIsActive = true
        
    case .endMatch:
        environment.workoutSession.endWorkout()
        state.matchIsActive = false
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}

typealias AppStore = Store<AppState, AppAction>
