//
//  IngredientListView.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import SwiftUI

private struct Ingredient: View {
    var text: String
    @State var struck = false
    
    var body: some View {
        Section {
            Image(systemName: struck ? "circle.fill" : "circle")
                .foregroundColor(Color.ui.accentColor)
                .font(Font.system(size: 8).weight(.black))
                .padding(6)
            Text(text.trimmingCharacters(in: NSCharacterSet.whitespaces))
                .strikethrough(struck)
                .padding(.leading, 8)
        }
            .onTapGesture {
                struck = !struck
            }
    }
}

struct IngredientListView: View {
    var ingredients: String
    
    private let columns = [
        GridItem(.fixed(10), alignment: .topLeading),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(ingredients.lines, id: \.self) { line in
                if !line.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
                    Ingredient(text: String(line))
                }
            }
        }
            .font(Font.body.weight(.semibold))
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        TextContainer {
            Text("Ingredient List View:")
                .modifier(SectionHeader())
            IngredientListView(
                ingredients: """
                     2 cans Beans
                     3 tbsp Adobo Sauce
                     1 egg
                     
                     Some Really Reallt long ingredient that should wrap
                    """
            )
        }
    }
}
