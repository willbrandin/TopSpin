//
//  MatchTrackingStateTetst.swift
//  TopSpinTests
//
//  Created by Will Brandin on 10/1/20.
//

import XCTest

@testable import TopSpin

class MatchTrackingStateTests: XCTestCase {
    var store: AppStore = AppStore(initialState: AppState(),
                                   reducer: appReducer,
                                   environment: AppEnvironment(settingsRepository: .mock,
                                                               matchRepository: .mock,
                                                               workoutSession: nil,
                                                               activeMatchController: nil))
    
    func testMatchTracking_CancelMatch() {
        let correlationId = UUID()
        store.send(.activeMatch(action: .start(settings: store.state.settingState.defaultSetting, correlation: correlationId)))
        
        var metrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
        var baseState = WorkoutState(heartMetrics: metrics, heartRate: 0, activeCalories: 0, elapsedSeconds: 0, startDate: Date(), endDate: nil, isActive: false)
        
        store.send(.workout(action: .start(correlation: UUID())))
        XCTAssert(store.state.workoutState.isActive)

        baseState.elapsedSeconds = 100
        baseState.heartRate = 124
        baseState.activeCalories = 30
        metrics = WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 132, minHeartRate: 110)
        baseState.heartMetrics = metrics

        XCTAssert(store.state.matchIsActive)
        
        store.send(.workout(action: .setWorkoutState(workout: baseState)))
        
        store.send(.activeMatch(action: .cancel))
        store.send(.workout(action: .reset))
        
        XCTAssertFalse(store.state.workoutState.isActive)
        XCTAssertFalse(store.state.matchIsActive)
        
        XCTAssert(store.state.matchHistory.matches.isEmpty)
        XCTAssertNil(store.state.matchHistory.matches.first)
        
        XCTAssert(store.state.activeMatchState.teamOneScore == 0)
        XCTAssert(store.state.activeMatchState.teamTwoScore == 0)
        XCTAssert(store.state.activeMatchState.servingTeam == .one)
        XCTAssertNil(store.state.activeMatchState.winningTeam)
        XCTAssertFalse(store.state.activeMatchState.teamDidWin)
        XCTAssertFalse(store.state.activeMatchState.isActive)
    }
    
    func testMatchTracking_SaveMatch_MismatchCorrelation() {
        let correlationId = UUID()
        store.send(.activeMatch(action: .start(settings: store.state.settingState.defaultSetting, correlation: correlationId)))
        
        var metrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
        var baseState = WorkoutState(heartMetrics: metrics, heartRate: 0, activeCalories: 0, elapsedSeconds: 0, startDate: Date(), endDate: nil, isActive: false)
        
        store.send(.workout(action: .start(correlation: UUID())))
        XCTAssert(store.state.workoutState.isActive)

        baseState.elapsedSeconds = 100
        baseState.heartRate = 124
        baseState.activeCalories = 30
        metrics = WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 132, minHeartRate: 110)
        baseState.heartMetrics = metrics

        XCTAssert(store.state.matchIsActive)
        
        let rallyState = RallyMatchState(teamOneScore: 11, teamTwoScore: 8, servingTeam: .one, teamHasGamePoint: false, winningTeam: .one)
        store.send(.activeMatch(action: .setRallyState(state: rallyState)))
        
        store.send(.workout(action: .setWorkoutState(workout: baseState)))
        store.send(.workout(action: .end))
        
        XCTAssertFalse(store.state.workoutState.isActive)

        store.send(.saveMatch)
        XCTAssertFalse(store.state.matchHistory.matches.isEmpty)
        XCTAssertNil(store.state.matchHistory.matches.first!.workout)

        store.send(.activeMatch(action: .complete))

        XCTAssert(store.state.activeMatchState.teamOneScore == 0)
        XCTAssert(store.state.activeMatchState.teamTwoScore == 0)
        XCTAssert(store.state.activeMatchState.servingTeam == .one)
        XCTAssertNil(store.state.activeMatchState.winningTeam)
        XCTAssertFalse(store.state.activeMatchState.teamDidWin)
        XCTAssertFalse(store.state.activeMatchState.isActive)
    }
    
    func testMatchTracking_SaveMatch_WithWorkout() {
        let correlationId = UUID()
        store.send(.activeMatch(action: .start(settings: store.state.settingState.defaultSetting, correlation: correlationId)))
        
        var metrics = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
        var baseState = WorkoutState(heartMetrics: metrics, heartRate: 0, activeCalories: 0, elapsedSeconds: 0, startDate: Date(), endDate: nil, isActive: false)
        
        store.send(.workout(action: .start(correlation: correlationId)))
        XCTAssert(store.state.workoutState.isActive)

        baseState.elapsedSeconds = 100
        baseState.heartRate = 124
        baseState.activeCalories = 30
        metrics = WorkoutHeartMetric(averageHeartRate: 120, maxHeartRate: 132, minHeartRate: 110)
        baseState.heartMetrics = metrics

        XCTAssert(store.state.matchIsActive)
        
        let rallyState = RallyMatchState(teamOneScore: 11, teamTwoScore: 8, servingTeam: .one, teamHasGamePoint: false, winningTeam: .one)
        store.send(.activeMatch(action: .setRallyState(state: rallyState)))
        
        store.send(.workout(action: .setWorkoutState(workout: baseState)))
        
        store.send(.workout(action: .end))
        XCTAssertFalse(store.state.workoutState.isActive)

        store.send(.saveMatch)
        XCTAssertFalse(store.state.matchHistory.matches.isEmpty)
        XCTAssertNotNil(store.state.matchHistory.matches.first!.workout)

        store.send(.activeMatch(action: .complete))
        store.send(.workout(action: .reset))

        XCTAssertFalse(store.state.workoutState.isActive)

        XCTAssert(store.state.activeMatchState.teamOneScore == 0)
        XCTAssert(store.state.activeMatchState.teamTwoScore == 0)
        XCTAssert(store.state.activeMatchState.servingTeam == .one)
        XCTAssertNil(store.state.activeMatchState.winningTeam)
        XCTAssertFalse(store.state.activeMatchState.teamDidWin)
        XCTAssertFalse(store.state.activeMatchState.isActive)
    }
    
    func testMatchTracking_SaveMatch_NoWorkout() {
        store.send(.activeMatch(action: .start(settings: store.state.settingState.defaultSetting, correlation: UUID())))
        
        XCTAssert(store.state.matchIsActive)
        
        let rallyState = RallyMatchState(teamOneScore: 11, teamTwoScore: 8, servingTeam: .one, teamHasGamePoint: false, winningTeam: .one)
        store.send(.activeMatch(action: .setRallyState(state: rallyState)))
        
        XCTAssert(store.state.activeMatchState.winningTeam == .one)
        XCTAssert(store.state.activeMatchState.teamDidWin)
        XCTAssertFalse(store.state.matchIsActive)

        store.send(.saveMatch)
        XCTAssertFalse(store.state.matchHistory.matches.isEmpty)

        store.send(.activeMatch(action: .complete))

        XCTAssert(store.state.activeMatchState.teamOneScore == 0)
        XCTAssert(store.state.activeMatchState.teamTwoScore == 0)
        XCTAssert(store.state.activeMatchState.servingTeam == .one)
        XCTAssertNil(store.state.activeMatchState.winningTeam)
        XCTAssertFalse(store.state.activeMatchState.teamDidWin)
        XCTAssertFalse(store.state.activeMatchState.isActive)
    }
}
