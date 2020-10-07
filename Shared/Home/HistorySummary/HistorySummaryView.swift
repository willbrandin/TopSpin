//
//  HistorySummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct HistorySummaryView: View {
        
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSize
    
    var summary: MatchSummary
    
    var backgroundColor: UIColor {
        return colorScheme == .dark ? .secondarySystemBackground : .systemBackground
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(summary.dateRange.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                }
                
                if horizontalSize != .regular {
                    Spacer()
                }
            }
            
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
                
                if horizontalSize != .regular {
                    Spacer()
                }
            }
            .frame(maxHeight: 50)
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
        .padding()
        .background(Color(backgroundColor))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0 : 0.05), radius: 8, x: 0, y: 4)
    }
}

struct HistorySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistorySummaryView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
            
            HistorySummaryView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
