//
//  File.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct Match: Equatable, Identifiable {
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
                               activeCalories: 132,
                               heartRateMetrics: .mock,
                               startDate: Date(),
                               endDate: Date().addingTimeInterval(5*123)))
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
