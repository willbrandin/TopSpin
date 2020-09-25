//
//  Persistance.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var standardContainer: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        loadFullAccountData(in: viewContext)
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TopSpin")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

#if DEBUG
extension PersistenceController {
    static func loadFullAccountData(in context: NSManagedObjectContext) {
        loadSettingsData(in: context)
        loadMatchData(in: context)
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func loadSettingsData(in context: NSManagedObjectContext) {
        var creationDateString = "2020-09-20T12:59:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let settings = MatchSetting(context: context)
        settings.createdDate = dateFormatter.date(from: creationDateString)
        settings.id = UUID()
        settings.isDefault = false
        settings.isTrackingWorkout = true
        settings.isWinByTwo = true
        settings.name = "Default"
        settings.scoreLimit = 11
        settings.serveInterval = 2
        
        creationDateString = "2020-09-21T12:59:00+0000"
        
        let myCustom = MatchSetting(context: context)
        myCustom.createdDate = dateFormatter.date(from: creationDateString)
        myCustom.id = UUID()
        myCustom.isDefault = true
        myCustom.isTrackingWorkout = true
        myCustom.isWinByTwo = true
        myCustom.name = "My 21 Settings"
        myCustom.scoreLimit = 21
        myCustom.serveInterval = 5
        
        creationDateString = "2020-09-20T12:59:00+0000"

        let relaxedCustom = MatchSetting(context: context)
        relaxedCustom.createdDate = dateFormatter.date(from: creationDateString)
        relaxedCustom.id = UUID()
        relaxedCustom.isDefault = false
        relaxedCustom.isTrackingWorkout = false
        relaxedCustom.isWinByTwo = false
        relaxedCustom.name = "My Relaxed Settings"
        relaxedCustom.scoreLimit = 21
        relaxedCustom.serveInterval = 5
    }
    
    static func loadMatchData(in context: NSManagedObjectContext) {
        
        var matchStartString = "2020-09-20T14:13:14+0000"
        var matchEndString = "2020-09-20T12:59:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // MATCH WINS
        
        for i in 0..<2 {
            let workout = Workout(context: context)
            workout.id = UUID()
            workout.activeCalories = 200
            workout.endDate = dateFormatter.date(from: matchEndString)
            workout.startDate = dateFormatter.date(from: matchStartString)
            workout.maxHeartRate = 146
            workout.minHeartRate = 112
            workout.averageHeartRate = 132
            
            let score = MatchScore(context: context)
            score.id = UUID()
            score.opponentScore = i % 2 == 0 ? 7 : 11
            score.playerScore = i % 2 == 0 ? 11 : 4
            
            let newItem = Match(context: context)
            newItem.workout = workout
            newItem.score = score
            newItem.date = Date()
            newItem.id = UUID()
            
            matchStartString = "2020-09-22T14:13:14+0000"
            matchEndString = "2020-09-22T12:39:00+0000"
        }
        
        // MATCH LOSES
        
        matchStartString = "2020-09-21T14:13:14+0000"
        matchEndString = "2020-09-21T12:59:00+0000"
        
        for i in 0..<2 {
            let workout = Workout(context: context)
            workout.id = UUID()
            workout.activeCalories = 132
            workout.endDate = dateFormatter.date(from: matchEndString)
            workout.startDate = dateFormatter.date(from: matchStartString)
            workout.maxHeartRate = 146
            workout.minHeartRate = 112
            workout.averageHeartRate = 132
            
            let score = MatchScore(context: context)
            score.id = UUID()
            score.opponentScore = i % 2 == 0 ? 7 : 11
            score.playerScore = i % 2 == 0 ? 11 : 4
            
            let newItem = Match(context: context)
            newItem.workout = workout
            newItem.score = score
            newItem.date = Date()
            newItem.id = UUID()
            
            matchStartString = "2020-09-23T14:13:14+0000"
            matchEndString = "2020-09-23T12:59:00+0000"
        }
    }
}
#endif
