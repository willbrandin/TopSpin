//
//  TopSpinTests.swift
//  TopSpinTests
//
//  Created by Will Brandin on 9/24/20.
//

import XCTest

@testable import TopSpin

class RallyTeamTests: XCTestCase {
    
    func testTeamToggle() {
        var team = RallyTeam.one
        team = team.toggle()
        XCTAssert(team == .two)
        
        team = team.toggle()
        XCTAssert(team == .one)
    }
}
