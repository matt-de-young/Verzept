//
//  EditRecipeView.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct EditRecipeView: View {
    @Binding var recipeData: Recipe.Data
//    @State private var ingredientData: Ingredient.Data = Ingredient.Data()
//    @State private var editIngredientIsPresented = false
//    @State private var editIngredientIndex: Int? = nil
    
    var body: some View {
        List {
            Section(header: Text("Recipe Info")) {
                TextField("Title", text: $recipeData.title)
            }
            Section(header: Text("Description")) {
                TextEditor(text: $recipeData.description)
                    .frame(minHeight: 200.0)
            }
//            Section(header: Text("Ingredients")) {
//                ForEach(Array(recipeData.ingredients.enumerated()), id: \.offset) { index, ingredient in
//                    HStack {
//                        Text("\(ingredient.ammount)")
//                        Text(ingredient.unit)
//                        Text(ingredient.name)
//                    }.onTapGesture {
//                        editIngredientIsPresented = true
//                        ingredientData = ingredient.data
//                        editIngredientIndex = index
//                    }
//                }.onDelete { indices in
//                    recipeData.ingredients.remove(atOffsets: indices)
//                }
//                Button(action: {
//                    editIngredientIsPresented = true
//                }, label: {
//                    HStack {
//                        Text("Add Ingredient")
//                        Spacer()
//                        Image(systemName: "plus.circle.fill")
//                            .accessibilityLabel(Text("Add ingredient"))
//                    }
//                })
//            }
//            Section(header: Text("Instructions")) {
//                TextEditor(text: $recipeData.instructions)
//                    .frame(minHeight: 200.0)
//            }
        }
        .listStyle(InsetGroupedListStyle())
//        .fullScreenCover(isPresented: $editIngredientIsPresented) {
//            NavigationView {
//                EditIngredientView(ingredientData: $ingredientData)
//                    .navigationBarItems(leading: Button("Cancel") {
//                        editIngredientIsPresented = false
//                        ingredientData = Ingredient.Data()
//                        editIngredientIndex = nil
//                    }, trailing: Button("Done") {
//                        editIngredientIsPresented = false
//                        let newIngredient = Ingredient(
//                            name: ingredientData.name,
//                            ammount: ingredientData.ammount,
//                            unit: ingredientData.unit,
//                            notes: ingredientData.notes
//                        )
//
//                        if (editIngredientIndex != nil) {
//                            recipeData.ingredients[editIngredientIndex!] = newIngredient
//                        } else {
//                            recipeData.ingredients.append(newIngredient)
//                        }
//                        ingredientData = Ingredient.Data()
//                        editIngredientIndex = nil
//                    })
//            }
//        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipeData: .constant(Recipe.data[0].data))
    }
}
