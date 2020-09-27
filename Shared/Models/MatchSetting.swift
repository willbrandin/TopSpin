//
//  MatchSetting.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

enum MatchScoreLimit: Int, CaseIterable {
    case eleven = 11
    case twentyOne = 21
}

enum MatchServeInterval: Int, CaseIterable {
    case everyTwo = 2
    case everyFive = 5
}

struct MatchSetting: Equatable, Identifiable {
    let id: UUID
    var createdDate: Date
    var isDefault: Bool
    var isTrackingWorkout: Bool
    var isWinByTwo: Bool
    var name: String
    var scoreLimit: MatchScoreLimit
    var serveInterval: MatchServeInterval
}

extension MatchSetting {
    static let defaultSettings = MatchSetting(id: UUID(), createdDate: Date(), isDefault: true, isTrackingWorkout: true, isWinByTwo: true, name: "Default", scoreLimit: .eleven, serveInterval: .everyTwo)
}
