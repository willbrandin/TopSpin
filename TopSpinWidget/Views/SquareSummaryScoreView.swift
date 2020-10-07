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
    static var previews: some View {
        SquareSummaryScoreView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 164, loses: 126, calories: 9867, avgHeartRate: 999))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
