//
//  Workout.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct Workout: Equatable {
    let id: UUID
    let activeCalories: Int
    let heartRateMetrics: WorkoutHeartMetric
    let startDate: Date
    let endDate: Date
}

struct WorkoutHeartMetric: Equatable {
    let averageHeartRate: Int
    let maxHeartRate: Int
    let minHeartRate: Int
}

extension WorkoutHeartMetric {
    static let mock = WorkoutHeartMetric(averageHeartRate: 143, maxHeartRate: 160, minHeartRate: 123)
}
