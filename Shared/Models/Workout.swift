//
//  Workout.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct Workout: Equatable, Codable {
    let id: UUID
    let activeCalories: Int
    let heartRateMetrics: WorkoutHeartMetric
    let startDate: Date
    let endDate: Date
    
    var duration: String {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let timePassed = timeInterval.truncatingRemainder(dividingBy: 3600)
        return Workout.elapsedTimeString(elapsed: Workout.secondsToHoursMinutesSeconds(seconds: Int(timePassed)))
    }
    
    var timeFrame: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let start = dateFormatter.string(from: startDate).lowercased()
        let end = dateFormatter.string(from: endDate).lowercased()
        
        return "\(start) - \(end)"
    }
    
    // Convert the seconds into seconds, minutes, hours.
    static func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Convert the seconds, minutes, hours into a string.
    static func elapsedTimeString(elapsed: (h: Int, m: Int, s: Int)) -> String {
        return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
    }
}

struct WorkoutHeartMetric: Equatable, Codable {
    let averageHeartRate: Int
    let maxHeartRate: Int
    let minHeartRate: Int
}

extension WorkoutHeartMetric {
    static let mock = WorkoutHeartMetric(averageHeartRate: 143, maxHeartRate: 160, minHeartRate: 123)
}
