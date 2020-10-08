//
//  HistorySummaryComplicationView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 10/7/20.
//

import SwiftUI
import ClockKit

struct HistorySummaryComplicationView: View {
    
    var summary: MatchSummary
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(summary.dateRange.uppercased())
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.secondary)
                .complicationForeground()
                .padding(.bottom, 2)
            
            HStack {
                VStack {
                    Text("WIN")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("\(summary.wins)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                        .complicationForeground()
                }
                
                Spacer()
                
                VStack {
                    Text("LOSS")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("\(summary.loses)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                Spacer()
                VStack {
                    Text("CAL")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("\(summary.calories)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                Spacer()
                VStack {
                    Text("HEART")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("\(summary.avgHeartRate)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                
                Spacer()
            }
        }
    }
}

struct HistorySummaryComplicationView_Previews: PreviewProvider {
    
    static let summary = MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 8, calories: 1689, avgHeartRate: 154)
    
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicRectangularFullView(HistorySummaryComplicationView(summary: summary))
                .previewContext()
            
            CLKComplicationTemplateGraphicRectangularFullView(HistorySummaryComplicationView(summary: summary))
                .previewContext(faceColor: .blue)
        }
    }
}
