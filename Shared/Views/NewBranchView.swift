//
//  NewBranchView.swift
//  Forking
//
//  Created by Matt de Young on 17.08.21.
//

import SwiftUI

struct NewBranchView: View {
    var recipe: Recipe
    @Binding var branchData: RecipeBranch.Data
    @Binding var selectedBranchIndex: Int
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("", text: $branchData.name)
            }
            Section(header: Text("Based on branch")) {
                Picker("Branch", selection: $selectedBranchIndex, content: {
                    ForEach(0..<recipe.branches.count, content: { index in
                        Text(recipe.branches[index].name)
                    })
                })
                .pickerStyle(WheelPickerStyle())
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("New Branch")
    }
}

struct NewBranchView_Previews: PreviewProvider {
    static var previews: some View {
        NewBranchView(
            recipe: Recipe.data[0],
            branchData: .constant(RecipeBranch.testData["BBBVegan"]!.data),
            selectedBranchIndex: .constant(0)
        )
    }
}
