//
//  EditRecipeView.swift
//  Forking
//
//  Created by Matt de Young on 12.08.21.
//

import SwiftUI

struct EditRecipeView: View {
    @Binding var recipeData: Recipe.Data
    
    var body: some View {
        List {
            Section(header: Text("Recipe Info")) {
                TextField("Title", text: $recipeData.title)
            }
            Section(header: Text("description")) {
                TextEditor(text: $recipeData.description)
                    .frame(minHeight: 200.0)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipeData: .constant(Recipe.data[0].data))
    }
}
