//
//  ActiveMatchReducer.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/30/20.
//

import Foundation
import Combine

struct ActiveMatchState: Equatable {
    var correlationId: UUID? = nil
    var isActive: Bool = false
    var teamOneScore: Int = 0
    var teamTwoScore: Int = 0
    var servingTeam: RallyTeam = .one
    var teamHasGamePoint: Bool = false
    var winningTeam: RallyTeam? = nil
    
    var teamDidWin: Bool {
        winningTeam != nil
    }
}

enum ActiveMatchAction {
    case observeActiveMatch
    case start(settings: MatchSetting, correlation: UUID?)
    case teamScored(team: RallyTeam)
    case setRallyState(state: RallyMatchState)
    case complete
    case cancel
}

@discardableResult
func activeMatchReducer(_ state: inout ActiveMatchState, _ action: ActiveMatchAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case .start(settings: let settings, correlation: let id):
        state.isActive = true
        
        let matchSettings = RallySettings(limit: settings.scoreLimit.rawValue, winByTwo: settings.isWinByTwo, serveInterval: settings.serveInterval.rawValue)
        environment.activeMatchController?.setMatchSettings(matchSettings)
        state.correlationId = id
                        
    case .complete, .cancel:
        environment.activeMatchController?.setNewGame()
        state = ActiveMatchState()
        
    case .teamScored(team: let team):
        environment.activeMatchController?.incrementScore(for: team)
       
    case .setRallyState(state: let rallyState):
        guard state.isActive else {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        state.servingTeam = rallyState.servingTeam
        state.teamOneScore = rallyState.teamOneScore
        state.teamTwoScore = rallyState.teamTwoScore
        state.teamHasGamePoint = rallyState.teamHasGamePoint
        state.winningTeam = rallyState.winningTeam
        
    case .observeActiveMatch:
        return environment.activeMatchController?.$matchState
            .map { rallyState in
                return AppAction.activeMatch(action: .setRallyState(state: rallyState))
            }
            .eraseToAnyPublisher() ?? Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
