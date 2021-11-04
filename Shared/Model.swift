//
//  Model.swift
//  Forking
//
//  Created by Matt de Young on 04.11.21.
//

import Foundation
import AuthenticationServices
import StoreKit

class Model: ObservableObject {
    
//    @Published var viewContext = PersistenceController.shared.container.viewContext
    @Published var selectedRecipeID: Recipe.ID?
    
    @Published var searchString = ""
    
}
