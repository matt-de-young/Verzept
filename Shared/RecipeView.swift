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
        ScrollView {
            HStack() {
                VStack(alignment: .leading) {
                    Text("Current branch: ") + Text(recipe.currentBranch.name).bold()
                    Text("Last Updated: \(Text(recipe.currentBranch.head.created, style: .date))")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                    NavigationLink(destination: BranchesView(recipe: $recipe)) {
                        HStack {
                            Text("View Branches")
                            Spacer()
                            Image(systemName: "arrow.branch")
                        }
                            .padding()
                    }
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                        .padding(.top)
                        .padding(.bottom)
                    
                    if !recipe.description.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Description:").font(.headline)
                            Text(recipe.description)
                        }.padding(.bottom)
                    }

                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Ingrdients:").font(.headline)
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                HStack {
                                    Text("\(ingredient.ammount)")
                                    Text(ingredient.unit)
                                    Text(ingredient.name)
                                }
                            }
                        }.padding(.bottom)
                    }
                    
                    if !(recipe.instructions.isEmpty) {
                        Text("Instructions:").font(.headline)
                        Text(recipe.instructions).padding(.bottom)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationTitle(recipe.title)
        .padding()
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
