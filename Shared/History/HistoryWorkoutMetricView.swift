//
//  HistoryWorkoutMetricView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import SwiftUI

struct WorkoutMetricContent {
    let startDate: Date
    let endDate: Date
    
    let calories: Int
    let avgHeartRate: Int
    let maxHeartRate: Int
    let minHeartRate: Int
    
    var duration: String {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let timePassed = timeInterval.truncatingRemainder(dividingBy: 3600) / 60
        return "\(Int(timePassed))"
    }
}

extension WorkoutMetricContent {
    init?(match: Match) {
        guard let start = match.workout?.startDate,
              let end = match.workout?.endDate,
              let calories = match.workout?.activeCalories,
              let avgHeartRate = match.workout?.averageHeartRate,
              let minHeartRate = match.workout?.minHeartRate,
              let maxHeartRate = match.workout?.maxHeartRate
        else {
            return nil
        }
        
        self.startDate = start
        self.endDate = end
        self.calories = Int(calories)
        self.avgHeartRate = Int(avgHeartRate)
        self.minHeartRate = Int(minHeartRate)
        self.maxHeartRate = Int(maxHeartRate)
    }
}

struct HistoryWorkoutMetricView: View {
    
    var metricContent: WorkoutMetricContent
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.yellow)
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Duration")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    HStack(spacing: 0) {
                        Text(metricContent.duration)
                            .font(.callout)
                            .bold()
                        Text("MIN")
                            .font(Font.callout.smallCaps())
                            .bold()
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.green)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    HStack(spacing: 0) {
                        Text("\(metricContent.calories)")
                            .bold()
                            .font(.callout)
                            
                        Text("CAL")
                            .font(Font.callout.smallCaps())
                            .bold()
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg. Pulse")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    HStack(spacing: 0) {
                        Text("\(metricContent.avgHeartRate)")
                            .font(.callout)
                            .bold()
                        Text("BPM")
                            .font(Font.callout.smallCaps())
                            .bold()
                    }
                }
            }
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
    }
}

struct HistoryWorkoutMetricView_Previews: PreviewProvider {
    
    static func content() -> WorkoutMetricContent {
        let matchStartString = "2020-09-20T14:13:14+0000"
        let matchEndString = "2020-09-20T12:59:00+0000"
        
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
        HistoryWorkoutMetricView(metricContent: content())
    }
}
