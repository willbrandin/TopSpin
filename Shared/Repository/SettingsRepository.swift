//
//  SettingsRepository.swift
//  TopSpin
//
//  Created by Will Brandin on 9/27/20.
//

import Foundation
import Combine
import CoreData

extension MatchSetting {
    init?(settings: CDMatchSetting) {
        guard let name = settings.name,
              let id = settings.id,
              let createdDate = settings.createdDate,
              let scoreLimit = MatchScoreLimit(rawValue: Int(settings.scoreLimit)),
              let serveInterval = MatchServeInterval(rawValue: Int(settings.serveInterval)) else {
            return nil
        }
        
        let isDefault = settings.isDefault
        let isTrackingWorkout = settings.isTrackingWorkout
        let isWinByTwo = settings.isWinByTwo
        
        self.init(id: id, createdDate: createdDate, isDefault: isDefault, isTrackingWorkout: isTrackingWorkout, isWinByTwo: isWinByTwo, name: name, scoreLimit: scoreLimit, serveInterval: serveInterval)
    }
}

class SettingsRepository: NSObject {
    
    @Published var settings: [MatchSetting] = []
    private var cdSettings: [CDMatchSetting] = []
    
    private let dueSoonController: NSFetchedResultsController<CDMatchSetting>
    private let context: NSManagedObjectContext
    
    var repoUpdatePublisher: AnyPublisher<[MatchSetting], Never> {
        return $settings.eraseToAnyPublisher()
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        dueSoonController = NSFetchedResultsController(fetchRequest: CDMatchSetting.sortedByDateFetchRequest,
                                                       managedObjectContext: managedObjectContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
        
        context = managedObjectContext
        
        super.init()
        
        dueSoonController.delegate = self
        
        do {
            try dueSoonController.performFetch()
            if let settings = dueSoonController.fetchedObjects {
                self.cdSettings = settings
                self.settings = settings.compactMap { MatchSetting(settings: $0) }
            }

        } catch {
            print("failed to fetch items!")
        }
    }
    
    func load() -> [MatchSetting] {
        return cdSettings.compactMap({ MatchSetting(settings: $0) })
    }
    
    func update(_ setting: MatchSetting) {
        let cdSetting = cdSettings.first(where: { $0.id == setting.id })!
        
        cdSetting.setValue(setting.name, forKey: "name")
        cdSetting.setValue(Int16(setting.scoreLimit.rawValue), forKeyPath: "scoreLimit")
        cdSetting.setValue(Int16(setting.serveInterval.rawValue), forKeyPath: "serveInterval")
        cdSetting.setValue(setting.isWinByTwo, forKeyPath: "isWinByTwo")
        cdSetting.setValue(setting.isTrackingWorkout, forKeyPath: "isTrackingWorkout")
        cdSetting.setValue(setting.isDefault, forKeyPath: "isDefault")
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func save(_ setting: MatchSetting) {
        let cdSetting = CDMatchSetting(context: context)
        cdSetting.name = setting.name
        cdSetting.createdDate = setting.createdDate
        cdSetting.id = setting.id
        cdSetting.isDefault = setting.isDefault
        cdSetting.isWinByTwo = setting.isWinByTwo
        cdSetting.isTrackingWorkout = setting.isTrackingWorkout
        cdSetting.scoreLimit = Int16(setting.scoreLimit.rawValue)
        cdSetting.serveInterval = Int16(setting.serveInterval.rawValue)

        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func delete(_ setting: MatchSetting) {
        cdSettings
            .filter({ $0.id == setting.id })
            .forEach { context.delete($0) }
                
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
}

extension SettingsRepository: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let settings = controller.fetchedObjects as? [CDMatchSetting]
        else { return }
        
        print("SettingsRepository - DID CHANGE CONTENT")
        self.cdSettings = settings
        self.settings = settings.compactMap { MatchSetting(settings: $0) }
    }
}

extension SettingsRepository {
    static let mock = SettingsRepository(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
}
