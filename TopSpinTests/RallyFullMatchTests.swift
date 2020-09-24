//
//  RallyTests.swift
//  RallyTests
//
//  Created by Will Brandin on 8/1/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import XCTest
@testable import TopSpin

class RallyFullMatchTests: XCTestCase {
    
    var matchController = RallyMatchController(settings: RallyMatchSettings.standard)
    
    func testFullMatch_standard() {
        XCTAssert(matchController.servingTeam == .one)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two) // 1-1
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .one) // 3-1
        
        XCTAssert(matchController.servingTeam == .one)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two) // 4-2
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .one) // 6-2
        
        XCTAssert(matchController.servingTeam == .one)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .one) // 8-2
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .one) // 10-2
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .two)
        matchController.incrementScore(for: .two) // 10-4
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .two) // 10-5
        matchController.incrementScore(for: .one) // 11-5
        
        XCTAssert(matchController.determineWin(for: .one))
        XCTAssert(matchController.teamDidWin)
        XCTAssert(matchController.teamOneScore == 11)
        XCTAssert(matchController.teamTwoScore == 5)
    }
    
    // FULL MATCH TEST
    func testServing_WithPastLimit() {
        XCTAssert(matchController.servingTeam == .one)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .one) // 2-2
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .one) // 4-4
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .one) // 6-6
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .one) // 8-8
        matchController.incrementScore(for: .one)
        matchController.incrementScore(for: .two)
        
        XCTAssert(matchController.servingTeam == .two) // 9-9
        matchController.incrementScore(for: .one) // 10 - 9 two score
        matchController.incrementScore(for: .two) // 10-10 two
        
        XCTAssert(matchController.servingTeam == .two) // 10-10
        matchController.incrementScore(for: .one) // 11-10 Team Two should serve
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .two) // 11-11 TeamTwo should still serve
        
        XCTAssert(matchController.servingTeam == .two)
        matchController.incrementScore(for: .two) // 11-12 Team one should serve
        
        XCTAssert(matchController.servingTeam == .one)
        matchController.incrementScore(for: .two) // 11-13 Team two wins
        
        XCTAssert(matchController.determineWin(for: .two))
    }
}
