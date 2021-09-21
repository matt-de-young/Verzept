//
//  Version+CoreDataProperties.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//
//

import Foundation
import CoreData


extension Version {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Version> {
        return NSFetchRequest<Version>(entityName: "Version")
    }

    @NSManaged public var id: UUID
    @NSManaged public var created: Date
    @NSManaged public var name: String
    @NSManaged public var ingredients: String
    @NSManaged public var directions: String
    @NSManaged public var notes: Set<Note>
    @NSManaged public var parent: Version?
    @NSManaged public var recipe: Recipe
    @NSManaged private var children: Set<Version>
    @NSManaged private var toHead: Branch
    @NSManaged private var toRoot: Branch
    
    convenience init(
        context: NSManagedObjectContext!,
        name: String = "",
        ingredients: String = "",
        directions: String = "",
        notes: Set<Note> = [],
        parent: Version? = nil
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Version", in: context)!
        self.init(entity: entity, insertInto: context)

        self.id = UUID()
        self.created = Date()
        self.name = name
        self.ingredients = ingredients
        self.directions = directions
        self.notes = notes
        self.parent = parent
    }
}

extension Version {
//    func descendants() -> [Version] {
//        var x: [Version] = []
//        x.append(self)
//        for child in children {
//            x.append(contentsOf: child.descendants())
//        }
//        return x
//    }
//    
//    func find(_ id: UUID) -> Version? {
//        if self.id == id {
//            return self
//        }
//        
//        for child in children {
//            if let match = child.find(id) {
//                return match
//            }
//        }
//        
//        return nil
//    }
}

// MARK: Generated accessors for notes
extension Version {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

// MARK: Generated accessors for children
extension Version {

    @objc(addChildrenObject:)
    @NSManaged public func addToChildren(_ value: Version)

    @objc(removeChildrenObject:)
    @NSManaged public func removeFromChildren(_ value: Version)

    @objc(addChildren:)
    @NSManaged public func addToChildren(_ values: NSSet)

    @objc(removeChildren:)
    @NSManaged public func removeFromChildren(_ values: NSSet)

}

extension Version : Identifiable {

}
