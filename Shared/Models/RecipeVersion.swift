//
//  RecipeVersion.swift
//  Forking
//
//  Created by Matt de Young on 15.08.21.
//

import Foundation

struct RecipeVersion: Identifiable, Codable, Equatable, Comparable {
    
    let id: UUID
    var name: String
    var ingredients: [Ingredient]
    var instructions: String
    var children: [RecipeVersion]
    var created: Date
    
    init(
        id: UUID = UUID(),
        name: String = "",
        ingredients: [Ingredient] = [],
        instructions: String = "",
        children: [RecipeVersion] = []
    ) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.children = children
        self.created = Date()
    }
}

extension RecipeVersion {
    struct Data {
        var name: String = ""
        var ingredients: [Ingredient] = []
        var instructions: String = ""
    }

    var data: Data {
        return Data(name: name, ingredients: ingredients, instructions: instructions)
    }
    
//    static func == (lhs: RecipeVersion, rhs: RecipeVersion) -> Bool {
//        return lhs.id == rhs.id
//    }
    
    static func < (lhs: RecipeVersion, rhs: RecipeVersion) -> Bool {
        lhs.ingredients == rhs.ingredients && lhs.instructions == rhs.instructions
    }
    
    mutating func add(child: RecipeVersion) {
        children.append(child)
    }
    
    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }
    
    func descendants() -> [RecipeVersion] {
        var x: [RecipeVersion] = []
        x.append(self)
        for child in children {
            x.append(contentsOf: child.descendants())
        }
        return x
    }
    
    func find(_ id: UUID) -> RecipeVersion? {
        if self.id == id {
            return self
        }
        
        for child in children {
            if let match = child.find(id) {
                return match
            }
        }
        
        return nil
    }
}

extension RecipeVersion {
    static var BBBVegan = RecipeVersion(
        name: "Vegan Version",
        ingredients: [
            Ingredient(name: "Beans", ammount: "2", unit: "cans"),
            Ingredient(name: "Adobo Sauce", ammount: "3", unit: UnitVolume.tablespoons.symbol),
            Ingredient(name: "Flax Seed", ammount: "2", unit: UnitVolume.tablespoons.symbol)
        ],
        instructions: """
         Adjust oven rack to center position and preheat oven to 350°F. Spread black beans in a single layer on a foil-lined
         rimmed baking sheet. Place in oven and roast until beans are mostly split open and outer skins are beginning to get
         crunchy, about 20 minutes. Remove from oven and allow to cool slightly.

         While beans roast, heat 2 tablespoons oil in a medium skillet over medium-high heat until shimmering. Add onion and
         poblano and cook, stirring frequently, until softened, about 5 minutes. Add garlic and cook, stirring constantly,
         until fragrant, about 2 minutes. Add chipotle chili and sauce and cook, stirring, until fragrant, about 30 seconds.
         Transfer mixture to a large bowl.
         """
    )
    static var BBBInit = RecipeVersion(
        name: "Init",
        ingredients: [
            Ingredient(name: "Beans", ammount: "2", unit: "cans"),
            Ingredient(name: "Adobo Sauce", ammount: "3", unit: UnitVolume.tablespoons.symbol),
            Ingredient(name: "Egg", ammount: "1")
        ],
        instructions: """
            Adjust oven rack to center position and preheat oven to 350°F. Spread black beans in a single layer on a foil-lined
            rimmed baking sheet. Place in oven and roast until beans are mostly split open and outer skins are beginning to get
            crunchy, about 20 minutes. Remove from oven and allow to cool slightly.

            While beans roast, heat 2 tablespoons oil in a medium skillet over medium-high heat until shimmering. Add onion and
            poblano and cook, stirring frequently, until softened, about 5 minutes. Add garlic and cook, stirring constantly,
            until fragrant, about 2 minutes. Add chipotle chili and sauce and cook, stirring, until fragrant, about 30 seconds.
            Transfer mixture to a large bowl.
            """,
        children: [BBBVegan]
    )
    static var JambalayaInit = RecipeVersion(
        name: "Red Jambalaya",
        ingredients: [
            Ingredient(name: "Rice", ammount: "500", unit: UnitMass.grams.symbol),
            Ingredient(name: "Tomato Puree", ammount: "2", unit: "cans"),
            Ingredient(name: "Andouille Sausage", ammount: "500", unit: UnitMass.grams.symbol)
        ]
    )
    static var GaletteInit = RecipeVersion(
        name: "Galette Des Rois"
    )
}
