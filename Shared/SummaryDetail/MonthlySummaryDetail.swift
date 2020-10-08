//
//  MonthlySummaryDetail.swift
//  TopSpin
//
//  Created by Will Brandin on 10/8/20.
//

import SwiftUI

struct MonthlySummaryDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSize
        
    var summary: MatchSummary
    
    var heartPoints: [Double] {
        return summary.matches
            .compactMap({ $0.workout?.heartRateMetrics.averageHeartRate })
            .compactMap({ Double($0) })
    }
    
    var caloriePoints: [Double] {
        return summary.matches
            .compactMap({ $0.workout?.activeCalories })
            .compactMap({ Double($0) })
    }
    
    var bodyContent: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(summary.dateRange.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                }
                
                Spacer()
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
    }
    
    var body: some View {
        VStack {
            bodyContent
        }
        .navigationTitle("SEP 2020")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MonthlySummaryDetail_Previews: PreviewProvider {
    
    static let matchRange: CountableClosedRange = 1...14
    static let summary =  MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: matchRange.map { _ in Match.mockMatch() })
    
    static var previews: some View {
        NavigationView {
            MonthlySummaryDetail(summary: summary)
        }
    }
}
