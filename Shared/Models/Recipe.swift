//
//  Recipie.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct Recipe: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var ingredients: [Ingredient]
    var instructions: String
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        ingredients: [Ingredient] = [],
        instructions: String = ""
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
    }
}

extension Recipe {
    static var data: [Recipe] {
        [
            Recipe(
                title: "Black Bean Burger",
                description: "Really tasty vegan burger using southwest flavors like Chipotle.",
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
                    """
            ),
            Recipe(
                title: "Red Jambalaya",
                ingredients: [
                    Ingredient(name: "Rice", ammount: "500", unit: UnitMass.grams.symbol),
                    Ingredient(name: "Tomato Puree", ammount: "2", unit: "cans"),
                    Ingredient(name: "Andouille Sausage", ammount: "500", unit: UnitMass.grams.symbol)
                ]
            ),
            Recipe(
                title: "Galette Des Rois",
                description: "January 6th is Epiphany Day in France and the tradition is to make a Galette des Rois (French King Cake) and share it with family or friends. Greedy people extend this day-long tradition to make more Galette des Rois during January."
            )
        ]
    }
}

extension Recipe {
    struct Data {
        var title: String = ""
        var description: String = ""
        var ingredients: [Ingredient] = []
        var instructions: String = ""
    }
    
    var data: Data {
        return Data(title: title, description: description, ingredients: ingredients, instructions: instructions)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        description = data.description
        ingredients = data.ingredients
        instructions = data.instructions
    }
}
