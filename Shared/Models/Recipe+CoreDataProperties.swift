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
import OSLog


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID
    @NSManaged public var created: Date
    @NSManaged public var title: String
    @NSManaged public var branches: Set<Branch>
    @NSManaged public var currentBranch: Branch
    @NSManaged private var versions: Set<Version>
    @NSManaged private var branchIndex: [UUID]
    
    var ingredients: String {
        return currentBranch.head.ingredients
    }
    
    var directions: String {
        return currentBranch.head.directions
    }
    
    var notes: Set<Note> {
        return currentBranch.head.notes
    }
    
    var sortedBranches: [Branch] {
        var ret: [Branch] = []
        for id in branchIndex {
            if let branch = branches.first(where: { $0.id == id }) {
                if branch == currentBranch {
                    ret.insert(branch, at: 0)
                } else {
                    ret.append(branch)
                }
            }
        }
        return ret
    }
    
    convenience init (
        context: NSManagedObjectContext!,
        title: String,
        ingredients: String = "",
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
        
        self.versions = [newVersion]
        self.branches = [newBranch]
        self.branchIndex = [newBranch.id] // TODO: There is some issue here. index is stored as "(\n    \"CFFC3E99-353A-4800-B209-F30079D63B90\"\n)"
        self.currentBranch = newBranch
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func delete(context: NSManagedObjectContext, recipe: Recipe) {
        context.delete(recipe)
        
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
        ingredients: String?,
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
            
            let newVersion = Version(
                context: context,
                name: versionName ?? replacementName,
                ingredients: ingredients ?? recipe.ingredients,
                directions: directions ?? recipe.directions,
                parent: recipe.currentBranch.head
            )
            recipe.addToVersions(newVersion)
            recipe.currentBranch.head = newVersion
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
        root: Version
    ) {
        let newBranch = Branch(context: context, name: name, root: root, head: root)
        recipe.addToBranches(newBranch)
        recipe.branchIndex.append(newBranch.id)
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
        recipe.branchIndex.removeAll(where: { $0 == branch.id })
        
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
    @NSManaged private func addToBranches(_ value: Branch)

    @objc(removeBranchesObject:)
    @NSManaged private func removeFromBranches(_ value: Branch)

    @objc(addBranches:)
    @NSManaged private func addToBranches(_ values: NSSet)

    @objc(removeBranches:)
    @NSManaged private func removeFromBranches(_ values: NSSet)

}

// MARK: Generated accessors for versions
extension Recipe {
    
    @objc(addVersionsObject:)
    @NSManaged private func addToVersions(_ value: Version)
    
    @objc(removeVersionsObject:)
    @NSManaged private func removeFromVersions(_ value: Version)
    
    @objc(addVersions:)
    @NSManaged private func addToVersions(_ values: NSSet)
    
    @objc(removeVersions:)
    @NSManaged private func removeFromVersions(_ values: NSSet)
    
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
