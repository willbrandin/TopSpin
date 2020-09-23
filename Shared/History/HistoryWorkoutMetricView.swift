//
//  HistoryWorkoutMetricView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import SwiftUI

struct HistoryWorkoutMetricView: View {
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
                        Text("20")
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
                        Text("1568")
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
                        Text("140")
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
    static var previews: some View {
        HistoryWorkoutMetricView()
    }
}
