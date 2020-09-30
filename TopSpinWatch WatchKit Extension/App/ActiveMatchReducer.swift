//
//  ActiveMatchReducer.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/30/20.
//

import Foundation
import Combine

struct ActiveMatchState: Equatable {
    var teamOneScore: Int = 0
    var teamTwoScore: Int = 0
    var heartRate: Int = 0
    var servingTeam: RallyTeam = .one
    var teamDidWin: Bool = false
    var teamHasGamePoint: Bool = false
}

enum ActiveMatchAction {
    case observeActiveMatch
    case start(settings: RallySettings)
    case teamScored(team: RallyTeam)
    case setHeartRate(rate: Int)
    case setTeamScore(team: RallyTeam, score: Int)
    case complete
    case cancel
}

@discardableResult
func activeMatchReducer(_ state: inout ActiveMatchState, _ action: ActiveMatchAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    default:
        break
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
