//
//  WorkoutMetricContent.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import Foundation

struct WorkoutMetricContent {
    let startDate: Date
    let endDate: Date
    
    let calories: Int
    let avgHeartRate: Int
    let maxHeartRate: Int
    let minHeartRate: Int
    
    var duration: String {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let timePassed = timeInterval.truncatingRemainder(dividingBy: 3600) / 60
        return "\(Int(timePassed))"
    }
}

extension WorkoutMetricContent {
    init(workout: Workout) {
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.calories = workout.activeCalories
        self.avgHeartRate = workout.heartRateMetrics.averageHeartRate
        self.minHeartRate = workout.heartRateMetrics.minHeartRate
        self.maxHeartRate = workout.heartRateMetrics.maxHeartRate
    }
}
