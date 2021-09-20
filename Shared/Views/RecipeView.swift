//
//  RecipeView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI
import CoreData

struct RecipeView: View {
    @State var viewContext: NSManagedObjectContext
    @ObservedObject var recipe: Recipe
    @State private var editRecipeisPresented = false
    @State private var branchesViewisPresented = false
    @State private var newNoteisPresented = false
    
    var body: some View {
        ScrollView {
            HStack() {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Branch:").font(.headline)
                        Text(recipe.currentBranch.name)
                        Text("Last Updated: \(Text(recipe.currentBranch.head.created, style: .date))")
                            .fontWeight(.light)
                            .font(.system(size: 12))
                    }
                    .padding(.bottom)
                    
                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading, content: {
                            Text("Ingrdients:").font(.headline)
                            IngredientListView(ingredients: recipe.ingredients)
                        })
                        .padding(.bottom)
                    }
                    
                    if !recipe.directions.isEmpty {
                        VStack(alignment: .leading, content: {
                            Text("Directions:").font(.headline)
                            Text(recipe.directions)
                        })
                        .padding(.bottom)
                    }
                    
                    if !recipe.notes.isEmpty {
                        Text("Notes:").font(.headline)
                        ForEach(Array(recipe.notes), id: \.self) { note in
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
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    newNoteisPresented = true
                }, label: {
                    Text("Add Note")
                    Image(systemName: "square.and.pencil")
                })
                Spacer()
                Button(action: {
                    branchesViewisPresented = true
                }, label: {
                    Text("Branches")
                    Image(systemName: "arrow.branch")
                })
            }
        }
        .sheet(isPresented: $editRecipeisPresented) {
            EditRecipeView(
                viewContext: viewContext,
                title: recipe.title,
                ingredients: recipe.ingredients,
                directions: recipe.directions
            ) { title, ingredients, directions, versionName in
                Recipe.update(
                    context: viewContext,
                    recipe: recipe,
                    title: title,
                    ingredients: ingredients,
                    directions: directions,
                    versionName: versionName
                )
                editRecipeisPresented = false
            }
        }
        .sheet(isPresented: $newNoteisPresented) {
            NavigationView {
                NewNoteView() { text in
                    Recipe.addNote(context: viewContext, recipe: recipe, text: text)
                    recipe.objectWillChange.send()
                    newNoteisPresented = false
                }
            }
        }
        .background(
            NavigationLink(
                destination: ListBranchesView(viewContext: viewContext, recipe: recipe.self),
                isActive: $branchesViewisPresented
            ) {
                EmptyView()
            }
        )
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(
            viewContext: PersistenceController.preview.container.viewContext,
            recipe: Recipe(
                context: PersistenceController.preview.container.viewContext,
                title: "Super Recipe",
                ingredients: """
                    1 cup Lorem
                    30 ml Ipsum
                    """,
                directions: """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
                    enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                    in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                    proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    """,
                notes: [
                    Note(context: PersistenceController.preview.container.viewContext, text: "Needs more salt.")
                ]
            )
        )
    }
}
