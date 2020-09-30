//
//  MatchHistoryReducer.swift
//  TopSpin
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct MatchHistoryState: Equatable {
    var matches: [Match] = []
}

enum MatchHistoryAction {
    case delete(match: Match)
}

func historyReducer(_ state: inout MatchHistoryState, _ action: MatchHistoryAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .delete(match):
        state.matches.removeAll(where: { $0.id == match.id })
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
