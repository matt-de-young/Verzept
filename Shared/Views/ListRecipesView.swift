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
    @State private var searchText: String = ""
    
    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest)
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        Container {
            ItemList {
                searchBar(text: $searchText)
                    .padding(.bottom)
                ForEach(recipes.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) { recipe in
                    NavigationLink(destination: RecipeView(viewContext: viewContext, recipe: recipe)) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(recipe.title)
                                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                                        .foregroundColor(Color.ui.headerColor)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text("Branch:")
                                    Text(recipe.currentBranch.name)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                                .font(Font.body.weight(.semibold))
                                .foregroundColor(Color.ui.accentColor)
                        }
                    }
                    .modifier(ListItem())
                    .animation(.default)
                }
            }
        }
        .navigationTitle("All Recipes")
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
        NavigationView {
            ListRecipesView()
        }
            .preferredColorScheme(.light)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        NavigationView {
            ListRecipesView()
        }
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
