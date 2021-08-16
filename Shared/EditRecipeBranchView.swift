//
//  EditRecipeBranchView.swift
//  Forking
//
//  Created by Matt de Young on 15.08.21.
//

import SwiftUI

struct EditRecipeBranchView: View {
    @Binding var recipe: Recipe
    
    @State private var recipeData: Recipe.Data = Recipe.Data()
    @State private var newBranchIsPresented = false
    @State private var focusedBranch: RecipeBranch? = nil
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        List() {
            Section() {
                ForEach(recipe.branches) { branch in
                    VStack(alignment: .leading) {
                        if (branch == recipeData.currentBranch) {
                            Text(branch.name).fontWeight(.heavy)
                        } else {
                            Text(branch.name)
                        }
                        Spacer()
                        if (branch == recipeData.currentBranch) {
                            Text(branch.head.created, style: .date)
                                .fontWeight(.semibold)
                                .font(.system(size: 12))
                        } else {
                            Text(branch.head.created, style: .date)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Text("Children: \(branch.head.count)")
                    }
                    .onTapGesture {
                        focusedBranch = branch
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button(action: {
            newBranchIsPresented = true
        }) {
            Image(systemName: "plus")
        })
        .actionSheet(item: $focusedBranch) { branch in
            ActionSheet(
                title: Text("\(branch.name)"),
                message: Text("Last updated ") + Text(branch.head.created, style: .relative) + Text(" ago"),
                buttons: [
                    .default(Text("Make Current")) {
                        recipe.setCurrentBranch(branch: branch)
                        self.mode.wrappedValue.dismiss()
                    },
                    .default(Text("Fork It!")) {
                        // TODO: Implement a recipe.createBranch()
                        self.mode.wrappedValue.dismiss()
                    },
                    .destructive(Text("Delete")) {
                        // TODO: Implement a recipe.deleteBranch() instead
                        var recipeData = recipe.data
                        guard let branchIndex = recipeData.branches.firstIndex(of: branch) else {
                            fatalError("Can't find Branch in Recipe")
                        }
                        recipeData.branches.remove(at: branchIndex)
                        recipe.update(from: recipeData)
                    },
                    .cancel()
                ]
            )
        }
    }
}

struct EditRecipeBranchView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeBranchView(recipe: .constant(Recipe.data[0]))
    }
}
