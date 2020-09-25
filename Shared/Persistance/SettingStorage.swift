//
//  SettingStorage.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import CoreData

extension MatchSetting {
    static var sortedByDateFetchRequest: NSFetchRequest<MatchSetting> {
        let request: NSFetchRequest<MatchSetting> = MatchSetting.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \MatchSetting.createdDate, ascending: false)
        ]
        
        return request
    }
}

class SettingStorage: NSObject, ObservableObject {
    
    @Published var settings: [MatchSetting] = []
    private let dueSoonController: NSFetchedResultsController<MatchSetting>
    private let context: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        dueSoonController = NSFetchedResultsController(fetchRequest: MatchSetting.sortedByDateFetchRequest,
                                                       managedObjectContext: managedObjectContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
        
        context = managedObjectContext
        
        super.init()
        
        dueSoonController.delegate = self
        
        do {
            try dueSoonController.performFetch()
            settings = dueSoonController.fetchedObjects ?? []
            
            if settings.isEmpty {
                setInitialSettings()
            }
            
        } catch {
            print("failed to fetch items!")
        }
    }
    
    func update(settings: MatchSetting, name: String, setAsDefault: Bool, scoreLimit: Int, serveInterval: Int, isWinByTwo: Bool, isTrackingWorkout: Bool) {
        
        settings.setValue(name, forKey: "name")
        settings.setValue(scoreLimit, forKeyPath: "scoreLimit")
        settings.setValue(serveInterval, forKeyPath: "serveInterval")
        settings.setValue(isWinByTwo, forKeyPath: "isWinByTwo")
        settings.setValue(isTrackingWorkout, forKeyPath: "isTrackingWorkout")
        settings.setValue(setAsDefault, forKeyPath: "isDefault")

        if self.settings.filter({ $0.isDefault }).isEmpty {
            if let setting = self.settings.first {
                setDefault(setting)
            }
        }
        
        if setAsDefault {
            self.settings.filter({$0.id != settings.id}).forEach {
                $0.setValue(false, forKey: "isDefault")
            }
        }

        if context.hasChanges {
            try? self.context.save()
        }
    }
    
    func addNew(name: String, setAsDefault: Bool, scoreLimit: Int, serveInterval: Int, isWinByTwo: Bool, isTrackingWorkout: Bool) {
        let settings = MatchSetting(context: context)
        settings.id = UUID()
        settings.name = name
        settings.scoreLimit = Int16(scoreLimit)
        settings.serveInterval = Int16(serveInterval)
        settings.isWinByTwo = isWinByTwo
        settings.isTrackingWorkout = isTrackingWorkout
        settings.isDefault = setAsDefault
        
        if setAsDefault {
            self.settings.filter({$0.id != settings.id}).forEach {
                $0.setValue(false, forKey: "isDefault")
            }
        }

        try? self.context.save()
    }
    
    func setDefault(_ setting: MatchSetting) {
        setting.setValue(true, forKey: "isDefault")
        
        self.settings.filter({$0.id != setting.id}).forEach {
            $0.setValue(false, forKey: "isDefault")
        }
    }
    
    func delete(_ settings: [MatchSetting]) {
        settings.forEach { context.delete($0) }
        
        save()
    }
    
    func save(_ saving: Bool = true) {
        if settings.isEmpty {
            setInitialSettings(false)
        }
        
        if settings.filter({ $0.isDefault }).isEmpty {
            if let setting = settings.first {
                setDefault(setting)
            }
        }
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func setInitialSettings(_ saving: Bool = true) {
        let settings = MatchSetting(context: context)
        settings.createdDate = Date()
        settings.id = UUID()
        settings.isDefault = true
        settings.isTrackingWorkout = true
        settings.isWinByTwo = true
        settings.name = "Default"
        settings.scoreLimit = 11
        settings.serveInterval = 2
        
        if saving {
            do {
                try context.save()
                print("DID SAVE DEFAULT SETTINGS")
            } catch {
                print("FAILED TO SAVE")
            }
        }
    }
}

extension SettingStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let settings = controller.fetchedObjects as? [MatchSetting]
        else { return }
        
        if settings.isEmpty {
            setInitialSettings()
        }
        
        if settings.filter({ $0.isDefault }).isEmpty {
            if let setting = settings.first {
                setDefault(setting)
            }
        }
        
        self.settings = settings
        print("SETTINGS UPDATED")
    }
}
