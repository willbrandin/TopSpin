//
//  AppStateInitTests.swift
//  TopSpinTests
//
//  Created by Will Brandin on 10/1/20.
//

import XCTest
@testable import TopSpin

class AppStateInitTests: XCTestCase {
    
    var store: AppStore = AppStore(initialState: AppState(),
                                   reducer: appReducer,
                                   environment: AppEnvironment(settingsRepository: .mock,
                                                               matchRepository: .mock,
                                                               workoutSession: nil,
                                                               activeMatchController: nil))
    
    func testInitialState() {
        XCTAssertFalse(store.state.matchIsActive)
        
        XCTAssert(store.state.matchHistory.matches.isEmpty)
        
        XCTAssert(store.state.settingState.settings.isEmpty)
        
        XCTAssert(store.state.workoutState.heartMetrics.averageHeartRate == 0)
        XCTAssert(store.state.workoutState.heartMetrics.maxHeartRate == 0)
        XCTAssert(store.state.workoutState.heartMetrics.minHeartRate == 0)
        XCTAssertFalse(store.state.workoutState.isActive)
        XCTAssert(store.state.workoutState.heartRate == 0)
        XCTAssert(store.state.workoutState.activeCalories == 0)
        XCTAssert(store.state.workoutState.elapsedSeconds == 0)
        XCTAssertNil(store.state.workoutState.startDate)
        XCTAssertNil(store.state.workoutState.endDate)

        XCTAssert(store.state.activeMatchState.teamOneScore == 0)
        XCTAssert(store.state.activeMatchState.teamTwoScore == 0)
        XCTAssert(store.state.activeMatchState.servingTeam == .one)
        XCTAssert(store.state.activeMatchState.teamDidWin == false)
        XCTAssert(store.state.activeMatchState.teamHasGamePoint == false)
        XCTAssertNil(store.state.activeMatchState.winningTeam)
    }
    
    func testAddSetting() {
        let setting = MatchSetting(id: UUID(), createdDate: Date(), isDefault: true, isTrackingWorkout: true, isWinByTwo: true, name: "MY MATCH SETTINGS", scoreLimit: .twentyOne, serveInterval: .everyFive)
        
        XCTAssert(store.state.settingState.settings.isEmpty)
        store.send(.settings(action: .add(setting: setting)))
        
        XCTAssert(store.state.settingState.settings.count == 1)
        XCTAssert(store.state.settingState.defaultSetting.id == setting.id)
    }
    
    func testUpdateSetting() {
        let id = UUID()
        let setting = MatchSetting(id: id, createdDate: Date(), isDefault: true, isTrackingWorkout: true, isWinByTwo: true, name: "MY MATCH SETTINGS", scoreLimit: .twentyOne, serveInterval: .everyFive)
        
        XCTAssert(store.state.settingState.settings.isEmpty)
        store.send(.settings(action: .add(setting: setting)))
        
        XCTAssert(store.state.settingState.settings.count == 1)
        XCTAssert(store.state.settingState.defaultSetting.id == setting.id)
        
        let updatedSetting = MatchSetting(id: id, createdDate: Date(), isDefault: false, isTrackingWorkout: true, isWinByTwo: false, name: "MY MATCH SETTINGS", scoreLimit: .twentyOne, serveInterval: .everyFive)
        
        store.send(.settings(action: .update(setting: updatedSetting)))
        XCTAssert(store.state.settingState.defaultSetting == .defaultSettings)
        XCTAssert(store.state.settingState.settings.first!.id == id)
        XCTAssert(store.state.settingState.settings.count == 1)
        XCTAssertFalse(store.state.settingState.settings.first!.isWinByTwo)
    }
    
    func testDeleteSetting() {
        let id = UUID()
        let setting = MatchSetting(id: id, createdDate: Date(), isDefault: true, isTrackingWorkout: true, isWinByTwo: true, name: "MY MATCH SETTINGS", scoreLimit: .twentyOne, serveInterval: .everyFive)
        
        XCTAssert(store.state.settingState.settings.isEmpty)
        store.send(.settings(action: .add(setting: setting)))
        
        XCTAssert(store.state.settingState.settings.count == 1)
        XCTAssert(store.state.settingState.defaultSetting.id == setting.id)
        
        store.send(.settings(action: .delete(setting: setting)))
        
        XCTAssert(store.state.settingState.settings.isEmpty)
        XCTAssert(store.state.settingState.defaultSetting == .defaultSettings)
    }
    
    func testAddMatch() {
        let match = Match.mockMatch()
        
        XCTAssert(store.state.matchHistory.matches.isEmpty)
        
        store.send(.matchHistory(action: .add(match: match)))
        XCTAssert(store.state.matchHistory.matches.count == 1)
        XCTAssert(store.state.matchHistory.matches.first! == match)
    }
    
    func testDeleteMatch() {
        let match = Match.mockMatch()
        
        XCTAssert(store.state.matchHistory.matches.isEmpty)
        
        store.send(.matchHistory(action: .add(match: match)))
        XCTAssert(store.state.matchHistory.matches.count == 1)
        XCTAssert(store.state.matchHistory.matches.first! == match)
        
        store.send(.matchHistory(action: .delete(match: match)))
        XCTAssert(store.state.matchHistory.matches.isEmpty)
    }
}
