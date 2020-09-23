//
//  MatchHistoryStorage.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import CoreData

extension Match {
    static var sortedByDateFetchRequest: NSFetchRequest<Match> {
        let request: NSFetchRequest<Match> = Match.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        return request
    }
}

class MatchStorage: NSObject, ObservableObject {
    
    @Published var matches: [Match] = []
    private let dueSoonController: NSFetchedResultsController<Match>
    private let context: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        dueSoonController = NSFetchedResultsController(fetchRequest: Match.sortedByDateFetchRequest,
                                                       managedObjectContext: managedObjectContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
        
        context = managedObjectContext
        
        super.init()
        
        dueSoonController.delegate = self
        
        do {
            try dueSoonController.performFetch()
            matches = dueSoonController.fetchedObjects ?? []
        } catch {
            print("failed to fetch items!")
        }
    }
    
    func addNew() {
        let workout = Workout(context: context)
        workout.id = UUID()
        workout.activeCalories = 200
        workout.totalCalories = 240
        workout.endDate = Date()
        workout.startDate = Date()
        workout.maxHeartRate = 146
        workout.minHeartRate = 112
        workout.averageHeartRate = 132
        
        let score = MatchScore(context: context)
        score.id = UUID()
        score.opponentScore = 32
        score.playerScore = 14
        
        let newItem = Match(context: context)
        newItem.workout = workout
        newItem.score = score
        newItem.date = Date()
        newItem.id = UUID()
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func delete(_ matches: [Match]) {
        matches.forEach { context.delete($0) }
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
}

extension MatchStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let matches = controller.fetchedObjects as? [Match]
        else { return }
        
        self.matches = matches
    }
}
