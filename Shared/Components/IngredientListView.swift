//
//  IngredientListView.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import SwiftUI

struct IngredientListView: View {
    var ingredients: [Ingredient]
    
    private let columns = [
        GridItem(.fixed(70)),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
            ForEach(ingredients, id: \.self) { ingredient in
                Text("\(ingredient.ammount) \(ingredient.unit)")
                Text(ingredient.name)
            }
        }
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListView(ingredients: RecipeVersion.BBBInit.ingredients)
    }
}
