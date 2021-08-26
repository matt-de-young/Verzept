//
//  Recipe.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

//import SwiftUI
//import CoreData
//import Foundation
//
//extension Recipe {
//
//    @NSManaged public var created: Date?
//    @NSManaged public var id: UUID?
//    @NSManaged public var title: String?
//    @NSManaged public var branches: Set<Ingredient>?
//    @NSManaged public var root: Version?
//    @NSManaged public var currentBranch: Branch?
//
//    static func create(
//        context: NSManagedObjectContext,
//        title: String,
//        ingredients: Set<Ingredient> = [],
//        directions: String = ""
//    ) {
//        let newRecipe = Recipe(context: context)
//        newRecipe.id = UUID()
//        newRecipe.created = Date()
//        newRecipe.title = title
//
//        let newRoot = Version(
//            name: "Init",
//            ingredients: ingredients,
//            directions: directions
//        )
//
//        let newBranch = Branch(name: "main", root: newRoot, head: newRoot)
//        newRecipe.branches = [newBranch]
//        newRecipe.currentBranch = newBranch
//
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//
//    static func delete(context: NSManagedObjectContext, recipes: FetchedResults<Recipe>, offsets: IndexSet) {
//        offsets.map { recipes[$0] }.forEach(context.delete)
//
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
    
//    static func update(recipe: Recipe, data: Recipe.Data) {
//        recipe.title = data.title
//    }
//}

//extension Recipe {
//    struct Data {
//        var title: String = ""
//        var branches: [Branch] = []
//        var currentBranch: Branch? = nil
//        var ingredients: [Ingredient] = []
//        var directions: String = ""
//    }
//
//    var data: Data {
//        return Data(
//            title: self.title ?? ""
////            branches: self.branches,
////            currentBranch: self.currentBranch,
////            ingredients: self.currentBranch?.head.ingredients,
////            directions: self.currentBranch?.head.directions
//        )
//    }
//}
