//
//  ContentView.swift
//  Shared
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct RecipesView: View {
    @Binding var recipes: [Recipe]
    let saveAction: () -> Void
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newRecipeData = Recipe.Data()
    
    var body: some View {
        List() {
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeView(recipe: binding(for: recipe))) {
                    Text(recipe.title)
                }
            }
        }
        .navigationTitle("All Recipes")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented){
            NavigationView {
                EditRecipeView(recipeData: $newRecipeData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newRecipe = Recipe(
                            title: newRecipeData.title,
                            description: newRecipeData.description
                        )
                        recipes.append(newRecipe)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    private func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let recipeIndex = recipes.firstIndex(where: { $0.id == recipe.id }) else {
            fatalError("Can't find recipe in array")
        }
        return $recipes[recipeIndex]
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesView(
                recipes: .constant(Recipe.data),
                saveAction: {}
            )
        }
    }
}
