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
    @NSManaged public var ingredients: Set<Ingredient>
    @NSManaged public var directions: String
    @NSManaged public var notes: Set<Note>
    @NSManaged private var children: Set<Version>
    @NSManaged private var recipe: Recipe
    @NSManaged private var toHead: Branch
    @NSManaged private var toRoot: Branch
    
    convenience init(
        context: NSManagedObjectContext!,
        name: String = "",
        ingredients: Set<Ingredient> = [],
        directions: String = "",
        notes: Set<Note> = []
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Version", in: context)!
        self.init(entity: entity, insertInto: context)

        self.id = UUID()
        self.created = Date()
        self.name = name
        self.ingredients = ingredients
        self.directions = directions
        self.notes = notes
    }

}

// MARK: Generated accessors for ingredients
extension Version {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

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
