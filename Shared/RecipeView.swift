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
    @State private var branchesViewisPresented = false
    @State private var editRecipeisPresented = false
    @State private var newNoteisPresented = false
    @State private var newNoteData = VersionNote.Data()

    var body: some View {
        ScrollView {
            HStack() {
                VStack(alignment: .leading) {
                    CurrentBranchView(recipe: $recipe)
                    DescriptionView(recipe: $recipe)
                    IngredientsView(recipe: $recipe)
                    InstructionsView(recipe: $recipe)
                    NotesView(recipe: $recipe)
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
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    branchesViewisPresented = true
                }, label: {
                    Text("Versions")
                    Image(systemName: "arrow.branch")
                })
                Spacer()
                Button(action: {
                    newNoteisPresented = true
                }, label: {
                    Text("Add Note")
                    Image(systemName: "square.and.pencil")
                })
            }
        }
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
        .sheet(isPresented: $newNoteisPresented) {
            NavigationView {
                NewNoteView(noteData: $newNoteData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        newNoteisPresented = false
                    }, trailing: Button("Add") {
                        recipe.currentBranch.head.add(note: VersionNote(text: newNoteData.text))
                        newNoteData = VersionNote.Data()
                        newNoteisPresented = false
                    })
            }
        }
        .background(
            NavigationLink(destination: BranchesView(recipe: $recipe), isActive: $branchesViewisPresented) {
                EmptyView()
            }
        )
    }
}

extension RecipeView {
    struct CurrentBranchView: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Version:").font(.headline)
                Text(recipe.currentBranch.name)
                Text("Last Updated: \(Text(recipe.currentBranch.head.created, style: .date))")
                    .fontWeight(.light)
                    .font(.system(size: 12))
            }
            .padding(.bottom)
        }
    }
    
    struct DescriptionView: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            if !recipe.description.isEmpty {
                VStack(alignment: .leading) {
                    Text("Description:").font(.headline)
                    Text(recipe.description)
                }
                .padding(.bottom)
            }
        }
    }
    
    struct IngredientsView: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            if !recipe.ingredients.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Ingrdients:").font(.headline)
                    IngredientListView(ingredients: recipe.ingredients)
                })
                .padding(.bottom)
            }
        }
    }
    
    struct InstructionsView: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            if !recipe.instructions.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Instructions:").font(.headline)
                    Text(recipe.instructions).padding(.bottom)
                })
                .padding(.bottom)
            }
        }
    }
    
    struct NotesView: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            if !recipe.notes.isEmpty {
                Text("Notes:").font(.headline)
                ForEach(recipe.notes, id: \.self) { note in
                    VStack(alignment: .leading) {
                        Text(note.created, style: .date)
                            .fontWeight(.light)
                            .font(.system(size: 12))
                        Text(note.text)
                    }
                    .padding(.bottom)
                }
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
