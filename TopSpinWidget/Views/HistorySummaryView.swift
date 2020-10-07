//
//  HistorySummaryView.swift
//  TopSpinWidgetExtension
//
//  Created by Will Brandin on 10/5/20.
//

import SwiftUI
import WidgetKit

struct HistorySummaryView: View {
        
    var summary: MatchSummary
  
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Monthly Summary")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(summary.dateRange.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                }
                Spacer()
            }
                            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Wins")
                        .font(.caption)
                        .foregroundColor(.green)
                        .bold()
                    
                    Text("\(summary.wins)")
                        .font(Font.system(.title, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Losses")
                        .font(.caption)
                        .foregroundColor(.red)
                        .bold()
                    Text("\(summary.loses)")
                        .font(Font.system(.title, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("\(summary.calories)")
                        .font(Font.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .bold()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg. Heart Rate")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("\(summary.avgHeartRate)")
                        .font(Font.system(.title, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .frame(maxHeight: 50)
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
        .padding()
        .clipShape(ContainerRelativeShape())
    }
}

struct HistorySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistorySummaryView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 4459, avgHeartRate: 145))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            HistorySummaryView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145))
                .redacted(reason: .placeholder)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
