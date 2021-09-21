//
//  IngredientListView.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import SwiftUI

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
                    Image(systemName: "circle")
                        .foregroundColor(Color.ui.accentColor)
                        .font(Font.system(size: 8).weight(.black))
                        .padding(6)
                    Text(line.trimmingCharacters(in: NSCharacterSet.whitespaces))
                        .padding(.leading, 8)
                }
            }
        }
    }
}

struct IngredientListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            HStack() {
                VStack(alignment: .leading) {
                    IngredientListView(
                        ingredients: """
                             2 cans Beans
                             3 tbsp Adobo Sauce
                             1 egg
                             
                             Some Really Reallt long ingredient that should wrap
                            """
                    )
                    Spacer()
                }
                .foregroundColor(Color.ui.foregroundColor)
                .font(Font.body.weight(.semibold))
                Spacer()
            }
        }
    }
}
