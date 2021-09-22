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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeView(viewContext: viewContext, recipe: recipe)) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(recipe.title)
                                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                                        .foregroundColor(Color.ui.headerColor)
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
                    .padding()
                    .background(Color.ui.fieldBackgroundColor)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.ui.foregroundColor, lineWidth: 2)
                    )
                }
            }
            .padding()
        }
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
        NavigationView {
            ZStack {
                Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
                ListRecipesView()
            }
        }
            .preferredColorScheme(.light)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        NavigationView {
            ZStack {
                Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
                ListRecipesView()
            }
        }
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
