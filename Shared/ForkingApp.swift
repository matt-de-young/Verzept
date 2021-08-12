//
//  ForkingApp.swift
//  Shared
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @ObservedObject private var data = RecipeData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RecipesView(recipes: $data.recipes) {
                    data.save()
                }
            }
            .onAppear{
                data.load()
            }
        }
    }
}
