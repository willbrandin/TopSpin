//
//  HeartRatesView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct HeartRatesView: View {
    
    var metrics: WorkoutHeartMetric
    
    var content: some View {
        HStack {
            HeartRateValueView(title: "AVG", subtitle: "\(metrics.averageHeartRate)")
                .padding(.trailing)

            Divider()

            HeartRateValueView(title: "MIN", subtitle: "\(metrics.minHeartRate)")
                .padding(.horizontal)

            Divider()

            HeartRateValueView(title: "MAX", subtitle: "\(metrics.maxHeartRate)")
                .padding(.horizontal)

            Spacer()
        }
    }
    
    var watchContent: some View {
            HStack(spacing: 8) {
                HeartRateValueView(title: "AVG", subtitle: "\(metrics.averageHeartRate)")
                
                HeartRateValueView(title: "MIN", subtitle: "\(metrics.minHeartRate)")
                
                HeartRateValueView(title: "MAX", subtitle: "\(metrics.maxHeartRate)")
                
                Spacer()
            }
    }
    
    var body: some View {
        #if os(watchOS)
        watchContent
        #else
        content
        #endif
    }
}

struct HeartRatesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeartRatesView(metrics: WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 123, minHeartRate: 123))
            HeartRatesView(metrics: WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 123, minHeartRate: 123))
                .colorScheme(.dark)
        }
    }
}
