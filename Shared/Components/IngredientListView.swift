//
//  IngredientListView.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import SwiftUI

struct IngredientListView: View {
    var ingredients: String
    
//    private let columns = [
//        GridItem(.fixed(70)),
//        GridItem(.flexible())
//    ]
    
    var body: some View {
//        LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
//            ForEach(ingredients, id: \.self) { ingredient in
//                Text("\(ingredient.quantity) \(ingredient.unit)")
//                Text(ingredient.name)
//            }
//        }
        Text(ingredients)
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
//        let context = PersistenceController.preview.container.viewContext
//        IngredientListView(ingredients: [
//            Ingredient(context: context, name: "Beans", quantity: "2", unit: "cans"),
//            Ingredient(context: context, name: "Adobo Sauce", quantity: "3", unit: UnitVolume.tablespoons.symbol),
//            Ingredient(context: context, name: "Egg", quantity: "1")
//        ])
        IngredientListView(ingredients: """
             2 cans Beans
             3 tbsp Adobo Sauce
             1 egg
            """)
    }
}
