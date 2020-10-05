//
//  HorizontalSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct HorizontalSummaryView: View {
    
    var historySummary: [MatchSummary]
    
    var body: some View {
        VStack {
            HStack {
                Text("Summary")
                    .padding(.horizontal)

                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(historySummary) { summary in
                        HistorySummaryView(summary: summary)
                            .frame(width: UIScreen.main.bounds.width - 32)

                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

struct HorizontalSummaryView_Previews: PreviewProvider {
    
    static let list = [
        MatchSummary(id: UUID(), dateRange: "SEP 2020", wins: 12, loses: 2, calories: 459, avgHeartRate: 145),
        MatchSummary(id: UUID(), dateRange: "AUG 2020", wins: 22, loses: 4, calories: 688, avgHeartRate: 138),
    ]
    
    static var previews: some View {
        Group {
            HorizontalSummaryView(historySummary: list)
                .preferredColorScheme(.dark)

            HorizontalSummaryView(historySummary: list)
                .background(Color(.secondarySystemBackground))
        }
    }
}
