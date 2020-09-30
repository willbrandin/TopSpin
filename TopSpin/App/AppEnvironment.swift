//
//  AppEnvironment.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

struct AppEnvironment {
    let settingsRepository: SettingsRepository
}

extension SettingsRepository {
    static let mock = SettingsRepository(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
}
