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
        NavigationView {
            List() {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeView(viewContext: viewContext, recipe: recipe)) {
                        VStack {
                            HStack {
                                Text(recipe.title)
                                    .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                                    .foregroundColor(Color.ui.headerColor)
                                Spacer()
                            }
                            HStack {
                                Text(recipe.currentBranch.name)
                                    .foregroundColor(Color.ui.foregroundColor)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Recipes")
            .foregroundColor(Color.ui.foregroundColor)
            .navigationBarItems(trailing: Button(action: {
                newRecipeIsPresented = true
            }) {
                Image(systemName: "plus").font(Font.body.weight(.semibold))
            })
        }
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
        ListRecipesView().preferredColorScheme(.light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        ListRecipesView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
