//
//  MatchHistoryRepository.swift
//  TopSpin
//
//  Created by Will Brandin on 9/30/20.
//

import Foundation
import Combine
import CoreData

extension Match {
    init?(match: CDMatch) {
        guard let date = match.date, let id = match.id, let score = match.score else {
            return nil
        }
        
        guard let scoreId = score.id else {
            return nil
        }
        
        let playerScore = Int(score.playerScore)
        let opponentScore = Int(score.opponentScore)
        let matchScore = MatchScore(id: scoreId, playerScore: playerScore, opponentScore: opponentScore)
        
        guard let workout = match.workout,
              let workoutId = workout.id,
              let start = workout.startDate,
              let end = workout.endDate else {
            self.init(id: id, date: date, score: matchScore, workout: nil)
            return
        }
        
        let activeCalories = Int(workout.activeCalories)
        let avgHeartRate = Int(workout.averageHeartRate)
        let minHeartRate = Int(workout.minHeartRate)
        let maxHeartRate = Int(workout.maxHeartRate)
        
        let matchWorkout = Workout(id: workoutId, activeCalories: activeCalories, heartRateMetrics: WorkoutHeartMetric(averageHeartRate: avgHeartRate, maxHeartRate: maxHeartRate, minHeartRate: minHeartRate), startDate: start, endDate: end)
        
        self.init(id: id, date: date, score: matchScore, workout: matchWorkout)
    }
}

class MatchHistoryRepository: NSObject {
    
    @Published var matchHistory: [Match] = []
    private var cdMatches: [CDMatch] = []
    private let dueSoonController: NSFetchedResultsController<CDMatch>
    private let context: NSManagedObjectContext
    
    var repoUpdatePublisher: AnyPublisher<[Match], Never> {
        return $matchHistory.eraseToAnyPublisher()
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        dueSoonController = NSFetchedResultsController(fetchRequest: CDMatch.sortedByDateFetchRequest,
                                                       managedObjectContext: managedObjectContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
        
        context = managedObjectContext
        
        super.init()
        
        dueSoonController.delegate = self
        
        do {
            try dueSoonController.performFetch()
            if let matches = dueSoonController.fetchedObjects {
                self.cdMatches = matches
                self.matchHistory = matches.compactMap { Match(match: $0) }
            }

        } catch {
            print("failed to fetch items!")
        }
    }
    
    func load() -> [Match] {
        return matchHistory
    }
    
    func save(_ match: Match) {
        let score = CDMatchScore(context: context)
        score.id = match.score.id
        score.playerScore = Int16(match.score.playerScore)
        score.opponentScore = Int16(match.score.opponentScore)
        
        let newItem = CDMatch(context: context)
        newItem.score = score
        newItem.date = match.date
        newItem.id = match.id
        
        if let matchWorkout = match.workout {
            let workout = CDWorkout(context: context)
            workout.id = matchWorkout.id
            workout.activeCalories = Int16(matchWorkout.activeCalories)
            workout.endDate = matchWorkout.endDate
            workout.startDate = matchWorkout.startDate
            workout.maxHeartRate = Int16(matchWorkout.heartRateMetrics.maxHeartRate)
            workout.minHeartRate = Int16(matchWorkout.heartRateMetrics.minHeartRate)
            workout.averageHeartRate = Int16(matchWorkout.heartRateMetrics.averageHeartRate)
            
            newItem.workout = workout
        }
        
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func delete(_ match: Match) {
        cdMatches
            .filter({ $0.id == match.id })
            .forEach { context.delete($0) }
                
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
}

extension MatchHistoryRepository: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let matches = controller.fetchedObjects as? [CDMatch] else {
            return
        }
        
        print("SettingsRepository - DID CHANGE CONTENT")
        self.cdMatches = matches
        self.matchHistory = matches.compactMap { Match(match: $0) }
    }
}

extension MatchHistoryRepository {
    static let mock = MatchHistoryRepository(managedObjectContext: PersistenceController.standardContainer.container.viewContext)
}
