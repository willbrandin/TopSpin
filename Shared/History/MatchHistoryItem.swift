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
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Duration")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    Text("20 min")
                        .font(.callout)
                        .bold()
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.green)
                    .font(.title2)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    Text("568 cal")
                        .font(.callout)
                        .bold()
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .font(.title2)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg. Pulse")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    Text("140 bpm")
                        .font(.callout)
                        .bold()
                }
            }
        }
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
                            .bold()
                            .foregroundColor(.green)
                        HStack {
                            Text("11")
                                .bold()
                            Text("-")
                                .bold()
                            Text("8")
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
            
            MatchHistoryItem()
                .padding()
        }
    }
}
