//
//  EditIngredientView.swift
//  Forking
//
//  Created by Matt de Young on 13.08.21.
//

import SwiftUI

struct EditIngredientView: View {
    @Binding var ingredientData: Ingredient.Data
    
    var body: some View {
        List {
            Section() {
                TextField("New Ingredient", text: $ingredientData.name)
            }
            Section() {
                HStack {
                    TextField("Ammount", text: $ingredientData.ammount)
                    TextField("Unit", text: $ingredientData.unit)
                }
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $ingredientData.notes)
                    .frame(minHeight: 200.0)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct EditIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        EditIngredientView(ingredientData: .constant(Recipe.data[0].currentBranch.head.ingredients[0].data))
    }
}
