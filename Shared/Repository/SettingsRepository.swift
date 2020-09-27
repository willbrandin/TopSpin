//
//  SettingsRepository.swift
//  TopSpin
//
//  Created by Will Brandin on 9/27/20.
//

import Foundation

class SettingsRepository {
    
    var settings: [MatchSetting] = [
        .defaultSettings,
        MatchSetting(id: UUID(), createdDate: Date(), isDefault: false, isTrackingWorkout: true, isWinByTwo: true, name: "21", scoreLimit: .twentyOne, serveInterval: .everyFive),
        MatchSetting(id: UUID(), createdDate: Date(), isDefault: false, isTrackingWorkout: false, isWinByTwo: true, name: "🥶 Chill", scoreLimit: .twentyOne, serveInterval: .everyFive)
    ]
    
    func load() -> [MatchSetting] {
        return settings
    }
    
    func save(_ settings: [MatchSetting]){
        self.settings = settings
    }
    
    func delete(_ setting: MatchSetting) {
        
    }
}
