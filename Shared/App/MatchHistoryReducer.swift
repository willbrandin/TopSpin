//
//  MatchHistoryReducer.swift
//  TopSpin
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct MatchSummary: Identifiable {
    let id = UUID()
    let dateRange: String
    let wins: Int
    let loses: Int
    let calories: Int
    let avgHeartRate: Int
    
    static func groupedMatchesByMonth(_ matches: [Match]) -> [Date: [Match]] {
        let empty: [Date: [Match]] = [:]
         return matches.reduce(into: empty) { acc, cur in
             let components = Calendar.current.dateComponents([.year, .month], from: cur.date)
             let date = Calendar.current.date(from: components)!
             let existing = acc[date] ?? []
             acc[date] = existing + [cur]
         }
    }
}

struct MatchHistoryState: Equatable {
    var matches: [Match] = [
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mock_nonWorkout_Match(),
        Match.mockMatch(),
        Match.mock_nonWorkout_Match(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch(),
        Match.mockMatch()
    ]
    
    var matchSummary: [MatchSummary] {
        var summaryList = [MatchSummary]()
        let groupedMatchesByMonth = MatchSummary.groupedMatchesByMonth(matches)
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MMM yyyy"
        
        groupedMatchesByMonth.forEach { date, matches in
            let title = dateFormmater.string(from: date)
            
            var totalWins = 0
            var totalLoses = 0
            var totalCalories = 0
            var totalHeartRate = 0
            
            matches.forEach { match in
                if match.score.playerScore > match.score.opponentScore {
                    totalWins += 1
                } else {
                    totalLoses += 1
                }
                
                totalCalories += match.workout?.activeCalories ?? 0
                totalHeartRate += match.workout?.heartRateMetrics.averageHeartRate ?? 0
            }
            
            let heartAverage = Int(totalHeartRate/matches.count)
            let summary = MatchSummary(dateRange: title, wins: totalWins, loses: totalLoses, calories: totalCalories, avgHeartRate: heartAverage)
            summaryList.append(summary)
        }
        
        return summaryList
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
