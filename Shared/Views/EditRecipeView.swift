//
//  EditRecipeView.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//

import SwiftUI
import CoreData

struct RecipeFormView: View {
    
    @State var viewContext: NSManagedObjectContext

    @State private var newIngredientIsPresented: Bool = false
    @State private var editIngredient: Ingredient? = nil
    
    @Binding var title: String
    @Binding var ingredients: [Ingredient]
    @Binding var directions: String
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $title)
            }
            Section(header: Text("Ingredients")) {
                ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
                    HStack {
                        Text("\(String?(ingredient.quantity ) ?? "")")
                        Text(ingredient.unit )
                        Text(ingredient.name )
                    }
                    .onTapGesture {
                        editIngredient = ingredient
                    }
                }
                .onDelete { indices in
                    withAnimation {
                        ingredients.remove(atOffsets: indices)
                    }
                }
                Button(action: {
                    newIngredientIsPresented = true
                }, label: {
                    HStack {
                        Text("Add Ingredient")
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Add ingredient"))
                    }
                })
            }
            Section(header: Text("Directions")) {
                TextEditor(text: $directions)
                    .frame(minHeight: 200.0)
            }
        }
        .sheet(isPresented: $newIngredientIsPresented) {
            NewIngredientView() { name, quantity, unit, notes in
                withAnimation {
                    ingredients.append(
                        Ingredient(
                            context: viewContext,
                            name: name,
                            quantity: quantity,
                            unit: unit,
                            notes: notes
                        )
                    )
                }
                newIngredientIsPresented = false
            }
        }
        .sheet(item: $editIngredient) { ingredient in
            EditIngredientView(
                name: ingredient.name,
                quantity: ingredient.quantity,
                unit: ingredient.unit,
                notes: ingredient.notes
            ) { name, quantity, unit, notes in
                let i = ingredients.firstIndex(of: ingredient)
                if i != nil {
                    ingredients[i!] = Ingredient(
                        context: viewContext,
                        name: name,
                        quantity: quantity,
                        unit: unit,
                        notes: notes
                    )
                }
                editIngredient = nil
            }
        }
    }
}

struct EditRecipeView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    
    @State var title: String
    @State var ingredients: [Ingredient]
    @State var directions: String
    let onComplete: (String, [Ingredient], String) -> Void
    
    var body: some View {
        NavigationView {
            RecipeFormView(
                viewContext: viewContext,
                title: $title,
                ingredients: $ingredients,
                directions: $directions
            )
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.body.weight(.regular)),
                trailing: Button("Update") {
                    onComplete(title, ingredients, directions)
                }
            )
        }
    }
}

struct CreateRecipeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    
    @State var title: String = ""
    @State var ingredients: [Ingredient] = []
    @State var directions: String = ""
    let onComplete: (String, [Ingredient], String) -> Void
    
    var body: some View {
        NavigationView {
            RecipeFormView(
                viewContext: viewContext,
                title: $title,
                ingredients: $ingredients,
                directions: $directions
            )
            .navigationBarTitle(Text("New Recipe"))
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.body.weight(.regular)),
                trailing: Button("Create") {
                    onComplete(title, ingredients, directions)
                }
            )
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView(
            viewContext: PersistenceController.preview.container.viewContext
        ) { title, ingredients, directions in
            
        }
        EditRecipeView(
            viewContext: PersistenceController.preview.container.viewContext,
            title: "Black Bean Burgers",
            ingredients: [],
            directions: ""
        ) { title, ingredients, directions in
            
        }
    }
}
