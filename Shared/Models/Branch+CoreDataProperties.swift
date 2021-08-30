//
//  Branch+CoreDataProperties.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//
//

import Foundation
import CoreData


extension Branch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Branch> {
        return NSFetchRequest<Branch>(entityName: "Branch")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var head: Version
    @NSManaged public var root: Version
    @NSManaged private var recipe: Recipe
    @NSManaged private var toCurrentBranch: Recipe

    convenience init (
        context: NSManagedObjectContext!,
        name: String,
        root: Version,
        head: Version
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Branch", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = UUID()
        self.name = name
        self.root = root
        self.head = head
    }
    
    static func update(
        context: NSManagedObjectContext,
        branch: Branch,
        name: String
    ) {
        branch.name = name
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension Branch {
    func history() -> [Version] {
        var path = [head]
        var x = head
        while true {
            if (x.parent == nil) {
                break
            }
            x = x.parent!
            path.append(x)
            if (x == root) {
                break
            }
        }
        return path
    }
    func fullHistory() -> [Version] {
        var path = [head]
        var x = head
        while true {
            if (x.parent == nil) {
                break
            }
            x = x.parent!
            path.append(x)
        }
        return path
    }
}

extension Branch : Identifiable {

}
