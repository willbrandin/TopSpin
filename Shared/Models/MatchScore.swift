//
//  MatchScore.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation

struct MatchScore: Equatable, Codable {
    let id: UUID
    let playerScore: Int
    let opponentScore: Int
}
