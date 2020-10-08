//
//  MatchSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSummaryWorkoutView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var workout: Workout
    
    var yellowColor: Color {
        #if os(watchOS)
        return .yellow
        #else
        return colorScheme == .dark ? .yellow : Color(UIColor.label)
        #endif
    }
  
    var largeMetricRow: some View {
        HStack {
            LargeMetricView(title: "Duration") {
                Text(workout.duration)
                    .foregroundColor(yellowColor)
            }
            
            Spacer()
            
            LargeMetricView(title: "Active Calories") {
                HStack(spacing: 0) {
                    Text("\(workout.activeCalories)")
                        .foregroundColor(.green)
                    Text("CAL")
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    var largeMetricList: some View {
        VStack(spacing: 4) {
            HStack {
                LargeMetricView(title: "Duration") {
                    Text(workout.duration)
                        .foregroundColor(yellowColor)
                }
                
                Spacer()
            }
                     
            Divider()

            HStack {
                LargeMetricView(title: "Active Calories") {
                    HStack(spacing: 0) {
                        Text("\(workout.activeCalories)")
                            .foregroundColor(.green)
                        Text("CAL")
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    var heartRateContent: some View {
        VStack(alignment: .leading) {
            Text("Heart Rate")
                .font(.headline)
            
            HeartRatesView(metrics: workout.heartRateMetrics)
        }
    }
    
    var workoutMetrics: some View {
        VStack(spacing: 4) {
            Divider()
            
            #if os(watchOS)
            largeMetricList
            #else
            largeMetricRow
            #endif
            
            Divider()

            #if os(watchOS)
            heartRateContent
            #else
            heartRateContent
                .padding()
            #endif
            
            Divider()
        }
    }
    
    var body: some View {
        workoutMetrics
    }
}

struct MatchSummaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var match: Match
    
    var content: some View {
        ScrollView {
            MatchSummaryScoreView(score: "\(match.score.playerScore)-\(match.score.opponentScore)",
                                  didWin: match.score.playerScore > match.score.opponentScore,
                                  date: match.workout?.timeFrame ?? match.startTime)
            
            if let workout = match.workout {
                MatchSummaryWorkoutView(workout: workout)
            } else {
                Text("No Workout Data")
                    .foregroundColor(.secondary)
                    .padding(16)
            }
        }
        .navigationTitle("Sat, Sep 9")
    }
    
    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}


struct MatchSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MatchSummaryView(match: .mockMatch())
            }
            
            NavigationView {
                MatchSummaryView(match: .mock_nonWorkout_Match())
            }
            .preferredColorScheme(.dark)
        }
    }
}
