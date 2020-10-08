//
//  MatchSummaryProvider.swift
//  TopSpin
//
//  Created by Will Brandin on 10/7/20.
//

import WidgetKit
import SwiftUI

struct MatchSummaryProvider: TimelineProvider {
    func placeholder(in context: Context) -> MatchSummary {
        let matches: [Match] = [.mockMatch()]
        return MatchSummary(id: UUID(), monthRange: Date(), wins: 32, loses: 18, calories: 5432, avgHeartRate: 143, matches: matches)
    }

    func getSnapshot(in context: Context, completion: @escaping (MatchSummary) -> ()) {
        let entry = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0, matches: [])
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MatchSummary>) -> ()) {
        let entry = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0, matches: [])

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
