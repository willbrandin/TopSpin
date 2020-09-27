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
}

extension Match {
    static let mock = Match(id: UUID(), date: Date(), score: MatchScore(id: UUID(), playerScore: 11, opponentScore: 8), workout: Workout(id: UUID(), activeCalories: 132, heartRateMetrics: .mock, startDate: Date(), endDate: Date()))
}
