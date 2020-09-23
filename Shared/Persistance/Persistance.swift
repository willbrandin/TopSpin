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
        
        for i in 0..<2 {
            let workout = Workout(context: viewContext)
            workout.id = UUID()
            workout.activeCalories = 200
            workout.totalCalories = 240
            workout.endDate = Date()
            workout.startDate = Date()
            workout.maxHeartRate = 146
            workout.minHeartRate = 112
            workout.averageHeartRate = 132
            
            let score = MatchScore(context: viewContext)
            score.id = UUID()
            score.opponentScore = i % 2 == 0 ? 7 : 11
            score.playerScore = i % 2 == 0 ? 11 : 4
            
            let newItem = Match(context: viewContext)
            newItem.workout = workout
            newItem.score = score
            newItem.date = Date()
            newItem.id = UUID()
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TopSpin")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
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
