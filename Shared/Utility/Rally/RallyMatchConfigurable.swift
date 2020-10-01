//
//  RallyMatchConfigurable.swift
//  Rally
//
//  Created by Will Brandin on 8/3/19.
//  Copyright © 2019 Will Brandin. All rights reserved.
//

import Foundation

public protocol RallyMatchConfigurable {
    var limit: Int { get }
    var winByTwo: Bool { get }
    var serveInterval: Int { get }
}

public struct RallySettings: RallyMatchConfigurable {
    public let limit: Int
    public let winByTwo: Bool
    public let serveInterval: Int
}

extension RallySettings {
    static let defaultMatchSettings = RallySettings(limit: 11, winByTwo: true, serveInterval: 2)
}
