//
//  TopSpinWidget.swift
//  TopSpinWidget
//
//  Created by Will Brandin on 10/5/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> MatchSummary {
        MatchSummary(id: UUID(), dateRange: "SEP 2020", wins: 32, loses: 18, calories: 5432, avgHeartRate: 143)
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

struct TopSpinWidgetEntryView : View {
    @Environment(\.widgetFamily) var size
    var entry: Provider.Entry

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

@main
struct TopSpinWidget: Widget {
    let kind: String = "TopSpinWidget.monthly.summary"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TopSpinWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TopSpinWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopSpinWidgetEntryView(entry: MatchSummary(id: UUID(), dateRange: "SEP 2020", wins: 32, loses: 18, calories: 5432, avgHeartRate: 143))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            TopSpinWidgetEntryView(entry: MatchSummary(id: UUID(), dateRange: "SEP 2020", wins: 32, loses: 18, calories: 5432, avgHeartRate: 143))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
