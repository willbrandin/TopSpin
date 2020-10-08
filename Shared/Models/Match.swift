//
//  File.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct Match: Equatable, Identifiable, Codable {
    let id: UUID
    let date: Date
    let score: MatchScore
    let workout: Workout?
    
    var shortDate: String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MMM d"
        
        return dateFormmater.string(from: date)
    }
    
    var startTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: date).lowercased()
    }
}

extension Match {
    static let mock = Match(id: UUID(),
                            date: Date(),
                            score: MatchScore(id: UUID(),
                                              playerScore: 11,
                                              opponentScore: 8),
                            workout: Workout(id: UUID(),
                                             activeCalories: 132,
                                             heartRateMetrics: .mock,
                                             startDate: Date(),
                                             endDate: Date()))
    
    static func mockMatch() -> Match {
        Match(id: UUID(),
              date: Date(),
              score: MatchScore(id: UUID(),
                                playerScore: 11,
                                opponentScore: 8),
              workout: Workout(id: UUID(),
                               activeCalories: Int.random(in: 80...134),
                               heartRateMetrics: WorkoutHeartMetric(averageHeartRate: Int.random(in: 144...154), maxHeartRate: Int.random(in: 155...165), minHeartRate: Int.random(in: 123...133)),
                               startDate: Date(),
                               endDate: Date().addingTimeInterval(5 * Double.random(in: 80...134))))
    }
    
    static func mock_nonWorkout_Match() -> Match {
        Match(id: UUID(),
              date: Date(),
              score: MatchScore(id: UUID(),
                                playerScore: 11,
                                opponentScore: 8),
              workout: nil)
    }
}
