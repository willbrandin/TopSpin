//
//  VerticalSummaryComplicationView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 10/7/20.
//

import SwiftUI
import ClockKit

struct VerticalSummaryComplicationView: View {
    
    var summary: MatchSummary

    var body: some View {
        VStack {
            HStack {
                Text("WINS")
                    .frame(width: 80, alignment: .leading)
                    .foregroundColor(.yellow)
                
                Text("\(summary.wins)")
                    .bold()
                    .foregroundColor(.green)
                    .complicationForeground()
                
                Spacer()
            }
            HStack {
                Text("LOSSES")
                    .frame(width: 80, alignment: .leading)
                    .foregroundColor(.yellow)
                
                Text("\(summary.loses)")
                    .bold()
                    .foregroundColor(.red)
                Spacer()
            }
            HStack {
                Text("CAL")
                    .frame(width: 80, alignment: .leading)
                    .foregroundColor(.yellow)
                
                Text("\(summary.calories)")
                    .bold()
                Spacer()
            }
            HStack {
                Text("HEART")
                    .frame(width: 80, alignment: .leading)
                    .foregroundColor(.yellow)
                
                Text("\(summary.avgHeartRate)")
                    .bold()
                Spacer()
            }
        }
        .font(.system(size: 14, weight: .regular, design: .rounded))
    }
}

struct VerticalSummaryComplicationView_Previews: PreviewProvider {
    
    static let summary = MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 8, calories: 689, avgHeartRate: 154)

    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicRectangularFullView(VerticalSummaryComplicationView(summary: summary))
                .previewContext()
            
            CLKComplicationTemplateGraphicRectangularFullView(VerticalSummaryComplicationView(summary: summary))
                .previewContext(faceColor: .blue)
        }
    }
}
