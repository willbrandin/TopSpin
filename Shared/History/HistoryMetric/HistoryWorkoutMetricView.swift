//
//  HistoryWorkoutMetricView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import SwiftUI

struct HistoryWorkoutMetricView: View {
    
    var metricContent: WorkoutMetricContent
    
    var body: some View {
        HStack(spacing: 0) {
            HorizontalIconView(image: Image(systemName:"clock"), tint: .yellow, title: "Duration", value: "\(metricContent.duration)", unit: "MIN")
            
            Spacer()
            
            HorizontalIconView(image: Image(systemName:"waveform.path.ecg"), tint: .green, title: "Calories", value: "\(metricContent.calories)", unit: "CAL")
            
            Spacer()
            
            HorizontalIconView(image: Image(systemName:"heart"), tint: .red, title: "Avg. Pulse", value: "\(metricContent.avgHeartRate)", unit: "BPM")
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
    }
}

struct HistoryWorkoutMetricView_Previews: PreviewProvider {
    
    static func content() -> WorkoutMetricContent {
        let matchStartString = "2020-09-20T14:13:00+0000"
        let matchEndString = "2020-09-20T14:43:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return WorkoutMetricContent(startDate: dateFormatter.date(from: matchStartString)!,
                                    endDate: dateFormatter.date(from: matchEndString)!,
                                    calories: 320,
                                    avgHeartRate: 132,
                                    maxHeartRate: 143,
                                    minHeartRate: 123)
    }
    
    static var previews: some View {
        Group {
            HistoryWorkoutMetricView(metricContent: content())
                .previewLayout(.sizeThatFits)
                .padding()
            
            HistoryWorkoutMetricView(metricContent: content())
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
