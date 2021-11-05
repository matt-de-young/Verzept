//
//  Model.swift
//  Forking
//
//  Created by Matt de Young on 04.11.21.
//

import Foundation
import AuthenticationServices
import StoreKit
import OSLog

class Model: ObservableObject {
    
    @Published var container = PersistenceController.shared.container
    @Published var selectedRecipeID: Recipe.ID?
    
    @Published var searchString = ""
    
}
