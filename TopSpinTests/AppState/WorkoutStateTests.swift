//
//  WorkoutStateTests.swift
//  TopSpinTests
//
//  Created by Will Brandin on 10/1/20.
//

import XCTest
import Combine

@testable import TopSpin

class WorkoutStateTests: XCTestCase {
    
    var store: AppStore = AppStore(initialState: AppState(),
                                   reducer: appReducer,
                                   environment: AppEnvironment(settingsRepository: nil,
                                                               matchRepository: nil,
                                                               workoutSession: nil,
                                                               activeMatchController: nil))
    
    func testActiveWorkout() {
        store.send(.workout(action: .start(correlation: nil)))
        XCTAssert(store.state.workoutState.isActive)
        
        store.send(.workout(action: .end))
        XCTAssertFalse(store.state.workoutState.isActive)
    }
    
    func testAddWorkoutState() {
        var metrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
        var baseState = WorkoutState(heartMetrics: metrics, heartRate: 0, activeCalories: 0, elapsedSeconds: 0, startDate: Date(), endDate: nil, isActive: false)
        
        store.send(.workout(action: .start(correlation: nil)))
        XCTAssert(store.state.workoutState.isActive)

        baseState.elapsedSeconds = 100
        baseState.heartRate = 124
        baseState.activeCalories = 30
        metrics = WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 132, minHeartRate: 110)
        baseState.heartMetrics = metrics
        
        store.send(.workout(action: .setWorkoutState(workout: baseState)))
        store.send(.workout(action: .end))
        
        XCTAssertFalse(store.state.workoutState.isActive)

        XCTAssert(store.state.workoutState.elapsedSeconds == 100)
        XCTAssert(store.state.workoutState.heartRate == 124)
        XCTAssert(store.state.workoutState.activeCalories == 30)
        XCTAssert(store.state.workoutState.heartMetrics.averageHeartRate == 120)
        XCTAssert(store.state.workoutState.heartMetrics.maxHeartRate == 132)
        XCTAssert(store.state.workoutState.heartMetrics.minHeartRate == 110)
    }
}
