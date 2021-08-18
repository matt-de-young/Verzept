//
//  Recipie.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var root: RecipeVersion
    var branches: [RecipeBranch]
    var currentBranch: RecipeBranch
    
    var ingredients: [Ingredient] {
        return currentBranch.head.ingredients
    }
    
    var instructions: String {
        return currentBranch.head.instructions
    }
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        root: RecipeVersion = RecipeVersion(),
        branches: [RecipeBranch] = [],
        currentBranch: RecipeBranch? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.root = root
        
        if (branches.isEmpty){
            self.branches = [RecipeBranch(name: "main", root: self.root, head: self.root)]
        } else {
            self.branches = branches
        }
        
        if (currentBranch == nil){
            self.currentBranch = self.branches[0]
        } else {
            self.currentBranch = currentBranch!
        }
    }
    
    mutating func setCurrentBranch(branch: RecipeBranch) {
        currentBranch = branch
    }
    
    mutating func deleteBranch(branch: RecipeBranch) {
        guard let branchIndex = branches.firstIndex(of: branch) else {
            fatalError("Can't find Branch in Recipe")
        }
        branches.remove(at: branchIndex)
    }
    
    mutating func createBranch(from: RecipeBranch.Data) -> RecipeBranch {
        
        print("Creating a new branch from \(from)")
        
        let newHead = RecipeVersion(
            name: from.name,
            ingredients: from.root?.ingredients ?? currentBranch.head.ingredients,
            instructions: from.root?.instructions ?? currentBranch.head.instructions
        )
        
        print("new head: \(newHead)")
        
        let newBranch = RecipeBranch(
            name: from.name,
            root: from.root ?? currentBranch.head,
            head: newHead
        )
        
        print("new branch: \(newBranch)")
        
        currentBranch.head.add(child: newHead)
        branches.append(newBranch)
        return newBranch
    }
}

extension Recipe {
    struct Data {
        var title: String = ""
        var description: String = ""
        var branches: [RecipeBranch] = []
        var currentBranch: RecipeBranch? = nil
        var ingredients: [Ingredient] = []
        var instructions: String = ""
    }
    
    var data: Data {
        return Data(
            title: title,
            description: description,
            branches: branches,
            currentBranch: currentBranch,
            ingredients: currentBranch.head.ingredients,
            instructions: currentBranch.head.instructions
        )
    }
    
    mutating func update(from data: Data) {
        title = data.title
        description = data.description
        branches = data.branches
        if (data.currentBranch != nil){
            currentBranch = data.currentBranch!
        }
        currentBranch.update(
            data: RecipeVersion.Data(
                ingredients: data.ingredients,
                instructions: data.instructions
            )
        )
    }
}

extension Recipe {
    static var data: [Recipe] {
        [
            Recipe(
                title: "Black Bean Burger",
                description: "Really tasty vegan burger using southwest flavors like Chipotle.",
                root: RecipeVersion.BBBInit,
                branches: [RecipeBranch.testData["BBBMain"]!, RecipeBranch.testData["BBBVegan"]!]
            ),
            Recipe(
                title: "Red Jambalaya",
                root: RecipeVersion.JambalayaInit,
                branches: [RecipeBranch.testData["JambalayaMain"]!]
            ),
            Recipe(
                title: "Galette Des Rois",
                description: """
                    January 6th is Epiphany Day in France and the tradition is to make a Galette des Rois (French King Cake) and share it
                    with family or friends. Greedy people extend this day-long tradition to make more Galette des Rois during January.
                    """,
                root: RecipeVersion.GaletteInit,
                branches: [RecipeBranch.testData["GaletteMain"]!]
            )
        ]
    }
}
