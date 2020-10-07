//
//  SummaryScoreWidget.swift
//  TopSpinWidgetExtension
//
//  Created by Will Brandin on 10/7/20.
//

import SwiftUI
import WidgetKit

struct SummaryScoreWidget: Widget {
    let kind: String = "TopSpinWidget.monthly.score.summary"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MatchSummaryProvider()) { entry in
            SquareSummaryScoreView(summary: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Monthly Match Results")
        .description("See your total wins and loses for the current month.")
    }
}
