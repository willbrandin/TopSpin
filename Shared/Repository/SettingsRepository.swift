//
//  SettingsRepository.swift
//  TopSpin
//
//  Created by Will Brandin on 9/27/20.
//

import Foundation
import Combine

class SettingsRepository {
    
    @Published var settings: [MatchSetting] = [
        MatchSetting(id: UUID(), createdDate: Date(), isDefault: false, isTrackingWorkout: true, isWinByTwo: true, name: "21", scoreLimit: .twentyOne, serveInterval: .everyFive),
        MatchSetting(id: UUID(), createdDate: Date(), isDefault: false, isTrackingWorkout: false, isWinByTwo: true, name: "🥶 Chill", scoreLimit: .twentyOne, serveInterval: .everyFive)
    ]
    
    var repoUpdatePublisher: AnyPublisher<[MatchSetting], Never> {
        return $settings.eraseToAnyPublisher()
    }
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            self.settings.remove(at: 1)
//        }
    }
    
    func load() -> [MatchSetting] {
        return settings
    }
    
    func save(_ settings: [MatchSetting]){
        self.settings = settings
    }
    
    func delete(_ setting: MatchSetting) {
        settings.removeAll(where: {
                            $0.id == setting.id
        })
    }
}
