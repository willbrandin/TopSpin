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
        MatchSummary(id: UUID(), monthRange: Date(), wins: 32, loses: 18, calories: 5432, avgHeartRate: 143)
    }

    func getSnapshot(in context: Context, completion: @escaping (MatchSummary) -> ()) {
        guard let entry = UserDefaultsManager.shared.summaryEntry else {
            return
        }
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MatchSummary>) -> ()) {
        guard let entry = UserDefaultsManager.shared.summaryEntry else {
            return
        }
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
