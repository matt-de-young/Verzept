//
//  ListRecipesView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI

struct ListRecipesView: View {

    @Environment(\.managedObjectContext) var viewContext
    @State private var newRecipeIsPresented = false
    
    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest)
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        List() {
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeView(viewContext: viewContext, recipe: recipe)) {
                    Text(recipe.title)
                }
            }
            .onDelete { offsets in
                withAnimation {
                    Recipe.delete(context: viewContext, recipes: recipes, offsets: offsets)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("All Recipes")
        .foregroundColor(Color.ui.foregroundColor)
        .navigationBarItems(trailing: Button(action: {
            newRecipeIsPresented = true
        }) {
            Image(systemName: "plus").font(Font.body.weight(.semibold))
        })
        .sheet(isPresented: $newRecipeIsPresented){
            CreateRecipeView(viewContext: viewContext) { title, ingredients, directions in
                withAnimation {
                    _ = Recipe(
                        context: viewContext,
                        title: title,
                        ingredients: ingredients,
                        directions: directions
                    )
                }
                newRecipeIsPresented = false
            }
        }
    }
}

struct ListRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
