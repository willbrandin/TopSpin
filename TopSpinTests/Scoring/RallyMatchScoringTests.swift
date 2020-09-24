//
//  RallyMatchScoringTests.swift
//  RallyTests
//
//  Created by Will Brandin on 8/19/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import XCTest
@testable import TopSpin

class RallyMatchScoringTests: XCTestCase {
    
    var matchController = RallyMatchController(settings: RallyMatchSettings.standard)

    func testIncrementTeamOneScore() {
        matchController.incrementScore(for: .one)
        XCTAssert(matchController.teamOneScore == 1)
    }
    
    func testIncrementTeamTwoScore() {
        matchController.incrementScore(for: .two)
        XCTAssert(matchController.teamTwoScore == 1)
    }
    
    func testIncrementFromSetValue() {
        matchController.teamOneScore = 8
        matchController.incrementScore(for: .one)
        
        XCTAssert(matchController.teamOneScore == 9)
    }
}
