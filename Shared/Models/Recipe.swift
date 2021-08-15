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
    var root: RecipeVersion?
    var head: RecipeVersion?
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        root: RecipeVersion? = nil,
        head: RecipeVersion? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.root = root
        self.head = head
    }
}

extension Recipe {
    struct Data {
        var title: String = ""
        var description: String = ""
        var versions: [RecipeVersion] = []
        var root: RecipeVersion?
        var head: RecipeVersion?
    }
    
    var data: Data {
        return Data(title: title, description: description, root: root, head: head)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        description = data.description
        if (data.head != nil) {
            head = data.head!
        }
    }
}

extension Recipe {
    static var data: [Recipe] {
        [
            Recipe(
                title: "Black Bean Burger",
                description: "Really tasty vegan burger using southwest flavors like Chipotle.",
                root: RecipeVersion.data[0],
                head: RecipeVersion.data[1]
            ),
            Recipe(
                title: "Red Jambalaya",
                root: RecipeVersion.data[2],
                head: RecipeVersion.data[2]
            ),
            Recipe(
                title: "Galette Des Rois",
                description: """
                    January 6th is Epiphany Day in France and the tradition is to make a Galette des Rois (French King Cake) and share it
                    with family or friends. Greedy people extend this day-long tradition to make more Galette des Rois during January.
                    """,
                root: RecipeVersion.data[3],
                head: RecipeVersion.data[3]
            )
        ]
    }
}
