//
//  ListRecipesView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI

struct ListRecipesView: View {

    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject private var model: Model
    @State private var newRecipeIsPresented = false
    @State private var searchText: String = ""
    @State private var selection: Recipe.ID?
    
    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest)
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        Container {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(tag: recipe.id, selection: $selection) {
                        RecipeView(recipe: recipe)
                    } label: {
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
                        .padding(.top)
                        .padding(.bottom)
                    }
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
            CreateRecipeView() { title, ingredients, directions in
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
            .environmentObject(Model())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        NavigationView {
            ListRecipesView()
        }
            .preferredColorScheme(.dark)
            .environmentObject(Model())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
