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
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String
    ) {
        self.id = id
        self.title = title
        self.description = description
    }
}

extension Recipe {
    static var data: [Recipe] {
        [
            Recipe(title: "Black Bean Burger", description: "Really tasty vegan burger using southwest flavors like Chipotle."),
            Recipe(title: "Red Jambalaya", description: "A creole classic."),
            Recipe(title: "Galette Des Rois", description: "January 6th is Epiphany Day in France and the tradition is to make a Galette des Rois (French King Cake) and share it with family or friends. Greedy people extend this day-long tradition to make more Galette des Rois during January.")
        ]
    }
}

extension Recipe {
    struct Data {
        var title: String = ""
        var description: String = ""
    }
    
    var data: Data {
        return Data(title: title, description: description)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        description = data.description
    }
}
