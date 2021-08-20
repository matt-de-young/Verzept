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
                    VStack(alignment: .leading) {
                        Text("Current branch: ") + Text(recipe.currentBranch.name).bold()
                        Text("Last Updated: \(Text(recipe.currentBranch.head.created, style: .date))")
                            .fontWeight(.light)
                            .font(.system(size: 12))
                    }
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

                    if !(recipe.notes.isEmpty) {
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
                        let newNote = VersionNote(text: newNoteData.text)
                        recipe.currentBranch.head.add(note: newNote)
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

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeView(recipe: .constant(Recipe.data[0]))
        }
    }
}
