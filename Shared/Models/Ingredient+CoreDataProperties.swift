//
//  Ingredient+CoreDataProperties.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var notes: String
    @NSManaged public var quantity: String
    @NSManaged public var unit: String
    @NSManaged private var toVersion: Version

    convenience init(
        context: NSManagedObjectContext!,
        name: String,
        quantity: String,
        unit: String = "",
        notes: String = ""
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.notes = notes
    }
    
    static func update(
        context: NSManagedObjectContext,
        ingredient: Ingredient,
        name: String?,
        quantity: String?,
        unit: String?,
        notes: String?
    ) {
        ingredient.name = name ?? ingredient.name
        ingredient.quantity = quantity ?? ingredient.quantity
        ingredient.unit = unit ?? ingredient.unit
        ingredient.notes = notes ?? ingredient.notes
        
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

extension Ingredient : Identifiable {

}
