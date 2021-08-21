//
//  CompareVersionsView.swift
//  Forking
//
//  Created by Matt de Young on 18.08.21.
//

import SwiftUI

struct CompareVersionsView: View {
    var recipe: Recipe
    var versionA: RecipeVersion

    @State var selectedBranchIndex = 0
    @State var versionB: RecipeVersion? = nil
    
    
    var body: some View {
        List() {
            Section(
                header: Text(versionA.name)
            ) {
                ForEach(versionA.ingredients, id: \.self) { ingredient in
                    HStack {
                        Text("\(ingredient.ammount)")
                        Text(ingredient.unit)
                        Text(ingredient.name)
                    }
                }
                Text(versionA.instructions)
            }
            if (versionB == nil) {
                Section(header: Text("Compare to branch")) {
                    Picker("Branch", selection: $selectedBranchIndex, content: {
                        ForEach(0..<recipe.branches.count, content: { index in
                            Text(recipe.branches[index].name)
//                            if (recipe.branches[index].head != versionA) {
//                                Text(recipe.branches[index].name)
//                            }
                        })
                    })
                    .pickerStyle(WheelPickerStyle())
                    Button("Compare") {
                        versionB = recipe.branches[selectedBranchIndex].head
                    }
                }
            } else {
                Section(
                    header: Text(versionB!.name)
                ) {
                    ForEach(versionB!.ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.ammount)")
                            Text(ingredient.unit)
                            Text(ingredient.name)
                        }
                    }
                    Text(versionB!.instructions)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct CompareVersionsView_Previews: PreviewProvider {
    static var previews: some View {
        CompareVersionsView(
            recipe: Recipe.data[0],
            versionA: RecipeBranch.testData["BBBMain"]!.head,
            versionB: RecipeBranch.testData["BBBVegan"]!.head
        );
        CompareVersionsView(
            recipe: Recipe.data[0],
            versionA: RecipeBranch.testData["BBBMain"]!.head,
            versionB: nil
        )
    }
}
