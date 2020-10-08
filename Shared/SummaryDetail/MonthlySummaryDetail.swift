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
                VStack(alignment: .leading, spacing: 4) {
                    Text("Wins")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .bold()
                    
                    Text("\(summary.wins)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Losses")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                    Text("\(summary.loses)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Spacer()
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("\(summary.calories)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .bold()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg. Heart Rate")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("\(summary.avgHeartRate)")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                Spacer()
                Spacer()
            }
            .frame(maxHeight: 50)
        }
    }
    
    var body: some View {
        VStack {
            bodyContent
                .padding()
            
            MetricGraphView(title: "Average Heart Rate", labels: summary.matches.map({ $0.shortDate }), data: heartPoints, foregroundColor: ColorGradient(.pink, .red))
            MetricGraphView(title: "Calories Burned", labels: summary.matches.map({ $0.shortDate }), data: caloriePoints, foregroundColor: ColorGradient(.green))
            
            Spacer()
        }
        .navigationTitle(summary.dateRange)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MonthlySummaryDetail_Previews: PreviewProvider {
    
    static let matchRange: CountableClosedRange = 1...14
    static let summary =  MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: matchRange.map { _ in Match.mockMatch() })
    
    static var previews: some View {
        Group {
            NavigationView {
                MonthlySummaryDetail(summary: summary)
            }
            NavigationView {
                MonthlySummaryDetail(summary: summary)
            }
            .preferredColorScheme(.dark)
        }
    }
}
