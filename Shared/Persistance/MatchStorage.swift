//
//  MatchHistoryStorage.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import CoreData

struct MatchWorkout {
    let id: UUID
    let activeCalories: Int
    let endDate: Date
    let startDate: Date
    let maxHeartRate: Int
    let minHeartRate: Int
    let avgHeartRate: Int
}

struct CompleteMatch {
    let id: UUID
    let opponentScore: Int
    let playerScore: Int
    let date: Date
    let workout: MatchWorkout
}

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
    
    func addNew(_ match: CompleteMatch) {
        let workout = Workout(context: context)
        workout.id = match.workout.id
        workout.activeCalories = Int16(match.workout.activeCalories)
        workout.endDate = match.workout.endDate
        workout.startDate = match.workout.startDate
        workout.maxHeartRate = Int16(match.workout.maxHeartRate)
        workout.minHeartRate = Int16(match.workout.minHeartRate)
        workout.averageHeartRate = Int16(match.workout.avgHeartRate)
        
        let score = MatchScore(context: context)
        score.id = UUID()
        score.opponentScore = Int16(match.opponentScore)
        score.playerScore = Int16(match.playerScore)
        
        let newItem = Match(context: context)
        newItem.workout = workout
        newItem.score = score
        newItem.date = match.date
        newItem.id = match.id
        
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
