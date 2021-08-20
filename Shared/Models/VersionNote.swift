//
//  RecipeNote.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import Foundation

struct VersionNote: Identifiable, Codable, Hashable, Equatable {
    
    var id: UUID
    var created: Date
    var text: String
    
    init(
        id: UUID = UUID(),
        text: String
    ) {
        self.id = id
        self.text = text
        self.created = Date()
    }
}

extension VersionNote {
    struct Data {
        var text: String = ""
    }
    
    var data: Data {
        return Data(text: text)
    }
}

extension VersionNote {
    static var TestData = [
        VersionNote(text: "Needs more salt"),
        VersionNote(text: "Too much baking soda")
    ]
}

