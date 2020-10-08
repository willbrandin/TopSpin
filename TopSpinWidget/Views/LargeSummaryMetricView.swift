//
//  LargeSummaryMetricView.swift
//  TopSpin
//
//  Created by Will Brandin on 10/8/20.
//

import SwiftUI
import WidgetKit

struct LargeSummaryMetricView: View {
    
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
    }
    
    var body: some View {
        VStack {
            bodyContent
                .padding(.horizontal)
            
            if heartPoints.isEmpty && caloriePoints.isEmpty {
                Spacer()
                VStack {
                    Spacer()
                    Text("No Metrics Available")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                VStack {
                    if !heartPoints.isEmpty {
                        MetricGraphView(title: "Average Heart Rate", labels: [], data: heartPoints, foregroundColor: ColorGradient(.pink, .red), height: 70)
                    }
                     
                    if !caloriePoints.isEmpty {
                        MetricGraphView(title: "Calories Burned", labels: [], data: caloriePoints, foregroundColor: ColorGradient(.green), height: 70)
                    }
                }
            }
        }
        .padding(.vertical)
        .clipShape(ContainerRelativeShape())
    }
}

struct LargeSummaryMetricView_Previews: PreviewProvider {
    static let summary = MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: [.mockMatch()])
    
    static var previews: some View {
        Group {
            LargeSummaryMetricView(summary: summary)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            LargeSummaryMetricView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 1, loses: 2, calories: 0, avgHeartRate: 0, matches: []))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            LargeSummaryMetricView(summary: MatchSummary(id: UUID(), monthRange: Date(), wins: 1, loses: 2, calories: 0, avgHeartRate: 0, matches: []))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
