//
//  MatchSummaryProvider.swift
//  TopSpin
//
//  Created by Will Brandin on 10/7/20.
//

import WidgetKit
import SwiftUI

struct MatchSummaryProvider: TimelineProvider {
    
    static let matchRange: CountableClosedRange = 1...50
    static let mockSummary = MatchSummary(id: UUID(), monthRange: Date(), wins: 32, loses: 18, calories: 5432, avgHeartRate: 143, matches: matchRange.map { _ in Match.mockMatch() })
 
    func placeholder(in context: Context) -> MatchSummary {
        return MatchSummaryProvider.mockSummary
    }

    func getSnapshot(in context: Context, completion: @escaping (MatchSummary) -> ()) {
        if context.isPreview {
            completion(MatchSummaryProvider.mockSummary)
        } else {
            let entry = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0, matches: [])
            
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MatchSummary>) -> ()) {
        let entry = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0, matches: [])

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
