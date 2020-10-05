//
//  SquareSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 10/5/20.
//

import SwiftUI

struct SquareSummaryView: View {
    
    var summary: MatchSummary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(summary.dateRange.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
                .bold()
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Wins")
                            .font(.caption)
                            .foregroundColor(.green)
                            .bold()
                        
                        Text("\(summary.wins)")
                            .font(Font.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                    }
                                        
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Cal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .bold()
                        Text("\(summary.calories)")
                            .font(Font.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .bold()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Loses")
                            .font(.caption)
                            .foregroundColor(.red)
                            .bold()
                        Text("\(summary.loses)")
                            .font(Font.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Heart")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .bold()
                        Text("\(summary.avgHeartRate)")
                            .font(Font.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
        .padding()
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct SquareSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SquareSummaryView(summary: MatchSummary(dateRange: "SEP 2020", wins: 164, loses: 126, calories: 9867, avgHeartRate: 999))
                .padding()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            SquareSummaryView(summary: MatchSummary(dateRange: "SEP 2020", wins: 164, loses: 126, calories: 9867, avgHeartRate: 999))
                .padding()
                .previewLayout(.sizeThatFits)
            
            SquareSummaryView(summary: MatchSummary(dateRange: "SEP 2020", wins: 164, loses: 126, calories: 9867, avgHeartRate: 999))
                .padding()
                .previewLayout(.sizeThatFits)
                .redacted(reason: .placeholder)
        }
    }
}
