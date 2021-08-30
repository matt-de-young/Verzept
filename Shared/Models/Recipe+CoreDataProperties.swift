//
//  Recipe+CoreDataProperties.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//
//

import Foundation
import CoreData
import SwiftUI


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID
    @NSManaged public var created: Date
    @NSManaged public var title: String
    @NSManaged public var branches: Set<Branch>
    @NSManaged public var currentBranch: Branch
    @NSManaged private var root: Version

    var ingredients: Set<Ingredient> {
        return currentBranch.head.ingredients
    }
    
    var directions: String {
        return currentBranch.head.directions
    }
    
    var notes: Set<Note> {
        return currentBranch.head.notes
    }
    
    convenience init (
        context: NSManagedObjectContext!,
        title: String,
        ingredients: Set<Ingredient> = [],
        directions: String = "",
        notes: Set<Note> = []
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)!
        self.init(entity: entity, insertInto: context)

        self.id = UUID()
        self.created = Date()
        self.title = title
        
        let newVersion = Version(context: context, name: "init", ingredients: ingredients, directions: directions, notes: notes)
        let newBranch = Branch(context: context, name: "main", root: newVersion, head: newVersion)
        
        self.branches = [newBranch]
        self.currentBranch = newBranch
        self.root = newVersion
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func delete(context: NSManagedObjectContext, recipes: FetchedResults<Recipe>, offsets: IndexSet) {
        offsets.map { recipes[$0] }.forEach(context.delete)

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func update(
        context: NSManagedObjectContext,
        recipe: Recipe,
        title: String?,
        ingredients: Set<Ingredient>?,
        directions: String?,
        versionName: String? = nil
    ) {
        if title != nil {
            recipe.title = title!
        }
        
        if (ingredients != nil || directions != nil) {
            
            var replacementName: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: Date())
            }
            
            recipe.currentBranch.head = Version(
                context: context,
                name: versionName ?? replacementName,
                ingredients: ingredients ?? recipe.ingredients,
                directions: directions ?? recipe.directions
            )
        }
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func addNote(
        context: NSManagedObjectContext,
        recipe: Recipe,
        text: String
    ) {

        recipe.currentBranch.head.addToNotes(Note(context: context, text: text))
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func addBranch(
        context: NSManagedObjectContext,
        recipe: Recipe,
        name: String,
        basedOn: Branch
    ) {
        
        let newBranch = Branch(context: context, name: name, root: basedOn.head, head: basedOn.head)
        recipe.addToBranches(newBranch)
        recipe.currentBranch = newBranch
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func setCurrentBranch(context: NSManagedObjectContext, recipe: Recipe, branch: Branch) {
        recipe.currentBranch = branch
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func deleteBranch(context: NSManagedObjectContext, recipe: Recipe, branch: Branch) {
        recipe.removeFromBranches(branch)
        
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

// MARK: Generated accessors for branches
extension Recipe {

    @objc(addBranchesObject:)
    @NSManaged public func addToBranches(_ value: Branch)

    @objc(removeBranchesObject:)
    @NSManaged public func removeFromBranches(_ value: Branch)

    @objc(addBranches:)
    @NSManaged public func addToBranches(_ values: NSSet)

    @objc(removeBranches:)
    @NSManaged public func removeFromBranches(_ values: NSSet)

}

extension Recipe : Identifiable {

}

extension Recipe {
    static var allRecipesFetchRequest: NSFetchRequest<Recipe> {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        return request
    }
}
