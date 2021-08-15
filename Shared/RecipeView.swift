//
//  RecipeView.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var recipeData: Recipe.Data = Recipe.Data()
    @State private var editRecipeisPresented = false

    var body: some View {
        List() {
            if !recipe.description.isEmpty {
                Section(header: Text("Description")) {
                    Text(recipe.description)
                }
            }
            if !(recipe.head?.ingredients.isEmpty)! {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.head!.ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.ammount)")
                            Text(ingredient.unit)
                            Text(ingredient.name)
                        }
                    }
                }
            }
            if !recipe.head!.instructions.isEmpty {
                Section(header: Text("Instructions")) {
                    Text(recipe.head!.instructions)
                }
            }
        }
        .navigationTitle(recipe.title)
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            editRecipeisPresented = true
            recipeData = recipe.data
        })
        .fullScreenCover(isPresented: $editRecipeisPresented) {
            NavigationView {
                EditRecipeView(recipeData: $recipeData)
                    .navigationTitle(recipe.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        editRecipeisPresented = false
                    }, trailing: Button("Done") {
                        editRecipeisPresented = false
                        recipe.update(from: recipeData)
                    })
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeView(recipe: .constant(Recipe.data[0]))
        }
    }
}
