//
//  RecipeBranch.swift
//  Forking
//
//  Created by Matt de Young on 15.08.21.
//

import Foundation

struct RecipeBranch: Identifiable, Codable, Equatable {
    
    let id: UUID
    var name: String
    var root: RecipeVersion
    var head: RecipeVersion
    
    init(
        id: UUID = UUID(),
        name: String,
        root: RecipeVersion,
        head: RecipeVersion
    ) {
        self.id = id
        self.name = name
        self.root = root
        self.head = head
    }
}

extension RecipeBranch {
    
    mutating func update(name: String? = nil, data: RecipeVersion.Data? = nil) {
        if (name != nil){
            self.name = name!
        }
        
        if (data != nil){
            let newHead = RecipeVersion(ingredients: data!.ingredients, instructions: data!.instructions)
            self.head.add(child: newHead)
            self.head = newHead
        }
    }
}

extension RecipeBranch {
    static private var BBBMain = RecipeBranch(name: "main", root: RecipeVersion.BBBInit, head: RecipeVersion.BBBInit)
    static private var BBBVegan = RecipeBranch(name: "Vegan Version", root: RecipeVersion.BBBInit, head: RecipeVersion.BBBVegan)
    static private var JambalayaMain = RecipeBranch(name: "main", root: RecipeVersion.JambalayaInit, head: RecipeVersion.JambalayaInit)
    static private var GaletteMain = RecipeBranch(name: "main", root: RecipeVersion.GaletteInit, head: RecipeVersion.GaletteInit)
    
    static var testData = [
        "BBBMain": BBBMain,
        "BBBVegan": BBBVegan,
        "JambalayaMain": JambalayaMain,
        "GaletteMain": GaletteMain,
    ]
}
