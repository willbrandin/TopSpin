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
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(historySummary) { summary in
                        NavigationLink(destination: MonthlySummaryDetail(summary: summary)) {
                            HistorySummaryView(summary: summary)
                        }
                        .buttonStyle(PlainButtonStyle())
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
        MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: [.mockMatch(), .mockMatch()]),
        MatchSummary(id: UUID(), monthRange: Date(), wins: 22, loses: 4, calories: 688, avgHeartRate: 138, matches: [.mockMatch(), .mockMatch()]),
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
