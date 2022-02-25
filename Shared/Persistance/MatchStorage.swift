//
//  MatchHistoryStorage.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import CoreData

extension CDMatch {
    static var sortedByDateFetchRequest: NSFetchRequest<CDMatch> {
        let request: NSFetchRequest<CDMatch> = CDMatch.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        return request
    }
}

class MatchStorage: NSObject, ObservableObject {
    
    @Published var matches: [CDMatch] = []
    private let dueSoonController: NSFetchedResultsController<CDMatch>
    private let context: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        dueSoonController = NSFetchedResultsController(fetchRequest: CDMatch.sortedByDateFetchRequest,
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
        do {
            try context.save()
            print("SAVED")
        } catch {
            print("FAILED TO SAVE")
        }
    }
    
    func delete(_ match: Match) {
        matches.filter( { $0.id == match.id }).forEach { context.delete($0) }
    }
    
    func delete(_ matches: [CDMatch]) {
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
        guard let matches = controller.fetchedObjects as? [CDMatch]
        else { return }
        
        self.matches = matches
    }
}

class MatchRepo: NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    private let colorController: NSFetchedResultsController<CDMatch>
    
    init(managedObjectContext: NSManagedObjectContext) {
        let sortDescriptors = [NSSortDescriptor(keyPath: \CDMatch.date!, ascending: true)]
        colorController = CDMatch.resultsController(context: managedObjectContext, sortDescriptors: sortDescriptors)
        super.init()
        colorController.delegate = self
        try? colorController.performFetch()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    var colors: [CDMatch] {
        return colorController.fetchedObjects ?? []
    }
}
extension CDMatch {
    static func resultsController(context: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor] = []) -> NSFetchedResultsController<CDMatch> {
        let request = NSFetchRequest<CDMatch>(entityName: "CDMatch")
        request.sortDescriptors = sortDescriptors.isEmpty ? nil : sortDescriptors
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}
