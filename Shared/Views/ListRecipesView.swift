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
    
//    var searchSuggestions: [Recipe] {
//        recipes.filter {
//            $0.title.localizedCaseInsensitiveContains(searchText) &&
//            $0.title.localizedCaseInsensitiveCompare(searchText) != .orderedSame
//        }
//    }
    
    var filteredRecipes: [Recipe] {
        recipes
            .filter { searchText.isEmpty ? true : $0.title.contains(searchText) }
            .sorted(by: { $0.title.localizedCompare($1.title) == .orderedAscending })
    }
    
    var body: some View {
        Container {
            List(filteredRecipes){ recipe in
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
                .padding(.bottom)
                .background(
                    NavigationLink(destination:RecipeView(recipe: recipe)) {}
                        .opacity(0)
                )
                .listRowBackground(Color.ui.backgroundColor)
                .listRowSeparatorTint(Color.ui.foregroundColor)
            }
            .animation(.default, value: filteredRecipes)
            .searchable(text: $searchText) {
//                ForEach(searchSuggestions) { suggestion in
//                    Text(suggestion.title).searchCompletion(suggestion.title)
//                        .listRowBackground(Color.ui.backgroundColor)
//                        .background(Color.ui.backgroundColor)
//                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {newRecipeIsPresented = true}) {
                        Image(systemName: "plus")
                            .font(Font.body.weight(.semibold))
                            .foregroundColor(Color.ui.accentColor)
                    }
                }
            }
        }
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
                .navigationTitle("All Recipes")
        }
            .preferredColorScheme(.light)
            .environmentObject(Model())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        NavigationView {
            ListRecipesView()
                .navigationTitle("All Recipes")
        }
            .preferredColorScheme(.dark)
            .environmentObject(Model())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
