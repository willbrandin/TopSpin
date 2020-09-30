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
    let workoutSession: WorkoutManager = WorkoutManager()
}
