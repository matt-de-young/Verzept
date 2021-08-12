//
//  RecipeView.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var data: Recipe.Data = Recipe.Data()
    @State private var isPresented = false

    var body: some View {
        List() {
            Section(header: Text("Description")) {
                Text(recipe.description)
            }
        }
        .navigationTitle(recipe.title)
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = recipe.data
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditRecipeView(recipeData: $data)
                    .navigationTitle(recipe.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                        recipe.update(from: data)
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
