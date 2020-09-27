//
//  MatchWorkoutView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI
import Combine

struct MatchWorkoutContainerView: View {
    
    @EnvironmentObject var store: AppStore
    var cancelAction: () -> Void
    
    init(cancelAction: @escaping () -> Void) {
        self.cancelAction = cancelAction
    }
        
    var body: some View {
        MatchWorkoutView(activeCalories: store.state.workoutState.activeCalories,
                         elapsedSeconds: store.state.workoutState.elapsedSeconds,
                         heartRate: store.state.workoutState.heartRate,
                         heartMetrics: store.state.workoutState.heartMetrics,
                         cancelAction: cancelAction)
    }
}

struct MatchWorkoutView: View {
         
    var activeCalories: Int
    var elapsedSeconds: Int
    var heartRate: Int
    var heartMetrics: WorkoutHeartMetric
    
    var cancelAction: () -> Void

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(elapsedTimeString(elapsed: secondsToHoursMinutesSeconds(seconds: elapsedSeconds)))")
                        .font(.title2)
                        .foregroundColor(.yellow)
                    
                    HStack {
                        Text("\(activeCalories)")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("ACTIVE")
                            Text("CAL")
                        }
                        .font(Font.system(size: 11))
                        .foregroundColor(.secondary)
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(heartRate)")
                            .font(.title2)
                        Text("BPM")
                            .font(Font.system(.title2).smallCaps())
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                            .padding(.leading)
                            .opacity(0.7)
                    }
                    
                    HStack {
                        
                        VStack {
                            Text("AVG")
                            Text("\(heartMetrics.averageHeartRate)")
                        }
                        
                        Spacer()
                        Divider()
                        Spacer()
                        
                        VStack {
                            Text("MIN")
                            Text("\(heartMetrics.minHeartRate)")
                        }
                        
                        Spacer()
                        Divider()
                        Spacer()
                        
                        VStack {
                            Text("MAX")
                            Text("\(heartMetrics.maxHeartRate)")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical)
                    
                    Button("Cancel", action: cancelAction)
                        .buttonStyle(BorderedButtonStyle(tint: .red))
                        .padding(.top)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Workout")
    }
    
    // Convert the seconds into seconds, minutes, hours.
    func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // Convert the seconds, minutes, hours into a string.
    func elapsedTimeString(elapsed: (h: Int, m: Int, s: Int)) -> String {
        return String(format: "%d:%02d:%02d", elapsed.h, elapsed.m, elapsed.s)
    }
}

struct MatchWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        MatchWorkoutView(activeCalories: 123, elapsedSeconds: 1231, heartRate: 133, heartMetrics: .mock, cancelAction: { })
            .environmentObject(WorkoutManager())
    }
}
