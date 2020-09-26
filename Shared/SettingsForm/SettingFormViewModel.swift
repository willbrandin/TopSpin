//
//  SettingFormViewModel.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

class SettingFormViewModel: ObservableObject {
        
    @ObservedObject var settingStore: SettingStorage
    
    @Published var settingsName: String = ""
    @Published var scoreLimit: Int = 11
    @Published var serveInterval: Int = 2
    @Published var winByTwo: Bool = true
    @Published var trackWorkoutData: Bool = true
    @Published var setAsDefault: Bool = true
    
    private var setting: MatchSetting?
    
    init(settingStore: SettingStorage, setting: MatchSetting? = nil) {
        self.settingStore = settingStore
        self.setting = setting
        
        if let setting = setting {
            self.settingsName = setting.name ?? ""
            self.scoreLimit = Int(setting.scoreLimit)
            self.serveInterval = Int(setting.serveInterval)
            self.winByTwo = setting.isWinByTwo
            self.trackWorkoutData = setting.isTrackingWorkout
            self.setAsDefault = setting.isDefault
        }
    }
    
    func saveAction() {
        if let setting = setting {
            update(setting)
        } else {
            save()
        }
    }
    
    private func save() {
        settingStore.addNew(name: settingsName,
                            setAsDefault: setAsDefault,
                            scoreLimit: scoreLimit,
                            serveInterval: serveInterval,
                            isWinByTwo: winByTwo,
                            isTrackingWorkout: trackWorkoutData)
    }
    
    private func update(_ setting: MatchSetting) {
        settingStore.update(settings: setting,
                            name: settingsName,
                            setAsDefault: setAsDefault,
                            scoreLimit: scoreLimit,
                            serveInterval: serveInterval,
                            isWinByTwo: winByTwo,
                            isTrackingWorkout: trackWorkoutData)
    }
}
