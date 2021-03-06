//
//  TopSpinWidget.swift
//  TopSpinWidget
//
//  Created by Will Brandin on 10/5/20.
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

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard let entry = UserDefaultsManager.shared.summaryEntry else {
            return
        }
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct MatchSummaryWidgetEntryView : View {
    @Environment(\.widgetFamily) var size
    var entry: MatchSummaryProvider.Entry

    var body: some View {
        switch size {
        case .systemSmall:
            SquareSummaryView(summary: entry)
            
        case .systemMedium:
            HistorySummaryView(summary: entry)
            
        default:
            SquareSummaryView(summary: entry)
        }
    }
}

struct MatchSummaryWidget: Widget {
    let kind: String = "TopSpinWidget.monthly.summary"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MatchSummaryProvider()) { entry in
            MatchSummaryWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Monthly Summary")
        .description("See your total wins, loses, and workout data for the current month.")
    }
}

struct TopSpinWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSummaryWidgetEntryView(entry: MatchSummary(id: UUID(), monthRange: Date(), wins: 32, loses: 18, calories: 5432, avgHeartRate: 143))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            MatchSummaryWidgetEntryView(entry: MatchSummary(id: UUID(), monthRange: Date(), wins: 32, loses: 18, calories: 5432, avgHeartRate: 143))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
