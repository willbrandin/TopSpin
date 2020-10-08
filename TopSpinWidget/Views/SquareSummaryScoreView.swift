//
//  SquareSummaryScoreView.swift
//  TopSpinWidgetExtension
//
//  Created by Will Brandin on 10/7/20.
//

import SwiftUI
import WidgetKit

struct SquareSummaryScoreView: View {
    var summary: MatchSummary
   
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(summary.dateRange.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .bold()
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Wins")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .bold()
                    
                    Text("\(summary.wins)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                
                VStack(alignment: .leading) {
                    Text("Losses")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                    Text("\(summary.loses)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
            }
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
        .padding()
        .clipShape(ContainerRelativeShape())
    }
}

struct SquareSummaryScoreView_Previews: PreviewProvider {
    static let summary =  MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: [.mockMatch()])

    static var previews: some View {
        SquareSummaryScoreView(summary: summary)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
