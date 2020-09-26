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
    init?(match: Match) {
        guard let start = match.workout?.startDate,
              let end = match.workout?.endDate,
              let calories = match.workout?.activeCalories,
              let avgHeartRate = match.workout?.averageHeartRate,
              let minHeartRate = match.workout?.minHeartRate,
              let maxHeartRate = match.workout?.maxHeartRate
        else {
            return nil
        }
        
        self.startDate = start
        self.endDate = end
        self.calories = Int(calories)
        self.avgHeartRate = Int(avgHeartRate)
        self.minHeartRate = Int(minHeartRate)
        self.maxHeartRate = Int(maxHeartRate)
    }
}
