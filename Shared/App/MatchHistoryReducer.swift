//
//  MatchHistoryReducer.swift
//  TopSpin
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct MatchHistoryState: Equatable {
    var matches: [Match] = [] {
        didSet {
            UserDefaultsManager.shared.summaryEntry = matchSummary.first
        }
    }
    
    var matchSummary: [MatchSummary] {
        var summaryList = [MatchSummary]()
        let groupedMatchesByMonth = MatchHistoryState.groupedMatchesByMonth(matches)
                
        groupedMatchesByMonth.forEach { date, matches in
            var totalWins = 0
            var totalLoses = 0
            var totalCalories = 0
            var totalHeartRate = 0
            var totalHeartEntries = 0
            
            matches.forEach { match in
                if match.score.playerScore > match.score.opponentScore {
                    totalWins += 1
                } else {
                    totalLoses += 1
                }
                
                totalCalories += match.workout?.activeCalories ?? 0
                totalHeartRate += match.workout?.heartRateMetrics.averageHeartRate ?? 0
                totalHeartEntries += match.workout?.heartRateMetrics.averageHeartRate != nil ? 1 : 0
            }
            
            let totalEntries = max(1, totalHeartEntries) // So that you cannot divide by 0
            let heartAverage = Int(totalHeartRate/totalEntries)
            let summary = MatchSummary(id: UUID(), monthRange: date, wins: totalWins, loses: totalLoses, calories: totalCalories, avgHeartRate: heartAverage)
            
            if date.isInThisMonth || date.isInThePast {
                summaryList.append(summary)
            }
        }
        
        return summaryList.sorted { $0.monthRange > $1.monthRange }
    }
    
    static private func groupedMatchesByMonth(_ matches: [Match]) -> [Date: [Match]] {
        let empty: [Date: [Match]] = [:]
         return matches.reduce(into: empty) { acc, cur in
             let components = Calendar.current.dateComponents([.year, .month], from: cur.date)
             let date = Calendar.current.date(from: components)!
             let existing = acc[date] ?? []
             acc[date] = existing + [cur]
         }
    }
}

enum MatchHistoryAction {
    case add(match: Match)
    case delete(match: Match)
}

func historyReducer(_ state: inout MatchHistoryState, _ action: MatchHistoryAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    case let .add(match):
        state.matches.append(match)
        environment.matchRepository?.save(match)
    
    case let .delete(match):
        state.matches.removeAll(where: { $0.id == match.id })
        environment.matchRepository?.delete(match)
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
