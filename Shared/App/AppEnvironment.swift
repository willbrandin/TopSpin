//
//  AppEnvironment.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    let settingsRepository: SettingsRepository?
    let matchRepository: MatchHistoryRepository?
    let workoutSession: WorkoutInteractable?
    let activeMatchController: RallyMatchController?
}
