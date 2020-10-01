//
//  ProtocolWorkoutInteractable.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 10/1/20.
//

import Foundation
import Combine

protocol WorkoutInteractable {
    var workoutPublisher: AnyPublisher<WorkoutState, Never> { get }
    var workoutEndDate: Date? { get }
    func requestAuthorization()
    func startWorkout()
    func pauseWorkout()
    func endWorkout()
}
