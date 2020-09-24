//
//  StandardSettingsTemplate.swift
//  RallyTests
//
//  Created by Will Brandin on 8/19/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation
@testable import TopSpin

struct RallyMatchSettings: RallyMatchConfigurable {
    var limit: Int
    var winByTwo: Bool
    var serveInterval: Int
}

extension RallyMatchSettings {
    static let standard = RallyMatchSettings(limit: 11, winByTwo: true, serveInterval: 2)
    static let playTo21 = RallyMatchSettings(limit: 21, winByTwo: true, serveInterval: 5)
    static let playTo11NoWinByTwo = RallyMatchSettings(limit: 11, winByTwo: false, serveInterval: 2)
}
