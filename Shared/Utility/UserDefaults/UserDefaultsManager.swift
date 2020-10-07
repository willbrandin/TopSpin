//
//  UserDefaultsManager.swift
//  TopSpin
//
//  Created by Will Brandin on 10/5/20.
//

import Foundation
#if !os(watchOS)
import WidgetKit
#endif

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private static let userDefaults = UserDefaults(suiteName: "group.com.willbrandin.dev.TopSpin")
    private static let summaryEntryKey = "summaryEntryKey"
    private static let encoder = JSONEncoder()
    
    var summaryEntry: MatchSummary? {
        get {
            if let saved = UserDefaultsManager.userDefaults?.object(forKey: UserDefaultsManager.summaryEntryKey) as? Data {
                let decoder = JSONDecoder()
                if let loadedAccount = try? decoder.decode(MatchSummary.self, from: saved) {
                    return loadedAccount
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        
        set {
            if let encoded = try? UserDefaultsManager.encoder.encode(newValue) {
                UserDefaultsManager.userDefaults?.set(encoded, forKey: UserDefaultsManager.summaryEntryKey)
                #if !os(watchOS)
                WidgetCenter.shared.reloadTimelines(ofKind: "TopSpinWidget.monthly.summary")
                WidgetCenter.shared.reloadTimelines(ofKind: "TopSpinWidget.monthly.score.summary")
                #endif
            }
        }
    }
}
