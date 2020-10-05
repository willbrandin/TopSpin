//
//  MatchSummary.swift
//  TopSpin
//
//  Created by Will Brandin on 10/5/20.
//

import Foundation

struct MatchSummary: Identifiable, Codable {
    let id: UUID
    let dateRange: String
    let wins: Int
    let loses: Int
    let calories: Int
    let avgHeartRate: Int
}
