//
//  existing.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct MatchWorkout {
    let id: UUID
    let activeCalories: Int
    let endDate: Date
    let startDate: Date
    let maxHeartRate: Int
    let minHeartRate: Int
    let avgHeartRate: Int
}

struct CompleteMatch {
    let id: UUID
    let opponentScore: Int
    let playerScore: Int
    let date: Date
    let workout: MatchWorkout
}
