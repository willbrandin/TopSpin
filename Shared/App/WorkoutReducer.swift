//
//  WorkoutReducerr.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/29/20.
//

import Foundation
import Combine

struct WorkoutState: Equatable {
    var correlationId: UUID? = nil
    var heartMetrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
    var heartRate = 0
    var activeCalories = 0
    var elapsedSeconds = 0
    var startDate: Date?
    var endDate: Date?
    var isActive: Bool = false
}

enum WorkoutAction {
    case start(correlation: UUID?)
    case end
    case reset
    case setWorkoutState(workout: WorkoutState)
    case pause
    case requestPermissions
    case observeWorkout
}

func workoutReducer(_ state: inout WorkoutState, _ action: WorkoutAction, _ environment: AppEnvironment) -> AnyPublisher<AppAction, Never>  {
    switch action {
    
    case .observeWorkout:
        return environment.workoutSession?
            .workoutPublisher
            .map { AppAction.workout(action: .setWorkoutState(workout: $0)) }
            .eraseToAnyPublisher() ?? Empty(completeImmediately: true).eraseToAnyPublisher()
    
    case .start(correlation: let id):
        state.correlationId = id
        state.isActive = true
        environment.workoutSession?.startWorkout()
        
    case .end:
        state.isActive = false
        environment.workoutSession?.endWorkout()
        state.endDate = environment.workoutSession?.workoutEndDate ?? Date()

    case .requestPermissions:
        environment.workoutSession?.requestAuthorization()
        
    case .pause:
        environment.workoutSession?.pauseWorkout()
        
    case .reset:
        state = WorkoutState()
        
    case let .setWorkoutState(workout):
        guard state.isActive else {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        state.heartMetrics = workout.heartMetrics
        state.heartRate = workout.heartRate
        state.activeCalories = workout.activeCalories
        state.elapsedSeconds = workout.elapsedSeconds
        state.startDate = workout.startDate
    }
    
    return Empty(completeImmediately: true).eraseToAnyPublisher()
}
