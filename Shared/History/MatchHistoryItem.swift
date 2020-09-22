//
//  MatchHistoryItem.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryItem: View {

    var workoutMetrics: some View {
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
    
    var backgroundColor: UIColor {
        #if os(watchOS)
        return .clear
        #else
        return .secondarySystemBackground
        #endif
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("WIN")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        HStack {
                            Text("13")
                                .bold()
                            Text("-")
                                .bold()
                            Text("11")
                                .bold()
                        }
                        .font(.title)
                    }
                    Spacer()
                    
                    Text("SEP 3")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                }
                
                #if os(iOS)
                    workoutMetrics
                #endif
            }
        }
        .padding()
        .background(Color(backgroundColor))
        .cornerRadius(8)
    }
}

struct MatchHistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchHistoryItem()
                .padding()
                .preferredColorScheme(.dark)
        
        }
    }
}
