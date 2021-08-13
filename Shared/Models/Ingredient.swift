//
//  Ingredient.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import Foundation
import SwiftUI

struct Ingredient: Codable, Hashable {
    var name: String
    var ammount: String
    var unit: String
    var notes: String
    
    init(
        name: String,
        ammount: String,
        unit: String = "",
        notes: String = ""
    ) {
        self.name = name
        self.ammount = ammount
        self.unit = unit
        self.notes = notes
    }
}

extension Ingredient {
    struct Data {
        var name: String = ""
        var ammount: String = ""
        var unit: String = ""
        var notes: String = ""
    }
    
    var data: Data {
        return Data(name: name, ammount: ammount, unit: unit, notes: notes)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        ammount = data.ammount
        unit = data.unit
        notes = data.notes
    }
}
