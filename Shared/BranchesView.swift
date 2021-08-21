//
//  EditRecipeBranchView.swift
//  Forking
//
//  Created by Matt de Young on 15.08.21.
//

import SwiftUI

struct BranchesView: View {
    @Binding var recipe: Recipe
    
    @State private var recipeData: Recipe.Data = Recipe.Data()
    @State private var actionBranch: RecipeBranch? = nil
    @State private var editBranch: RecipeBranch? = nil
    @State private var newBranchIsPresented: Bool = false
    @State private var newBranchData = RecipeBranch.Data()
    @State private var selectedBranchIndex = 0
    @State private var compareBranchA: RecipeBranch? = nil
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        List() {
            Section() {
                ForEach(recipe.branches) { branch in
                    VStack(alignment: .leading) {
                        if (branch == recipe.currentBranch) {
                            Text(branch.name).fontWeight(.heavy)
                        } else {
                            Text(branch.name)
                        }
                        Spacer()
                        if (branch == recipe.currentBranch) {
                            Text(branch.head.created, style: .date)
                                .fontWeight(.semibold)
                                .font(.system(size: 12))
                        } else {
                            Text(branch.head.created, style: .date)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                    }
                    .onTapGesture {
                        actionBranch = branch
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
        .actionSheet(item: $actionBranch) { branch in
            ActionSheet(
                title: Text("\(branch.name)"),
                message: Text("Last updated \(Text(branch.head.created, style: .relative)) ago"),
                buttons: [
                    .default(Text("Make Current").bold()) {
                        recipe.setCurrentBranch(branch: branch)
                        self.mode.wrappedValue.dismiss()
                    },
                    .default(Text("Edit")) {
                        editBranch = branch
                        newBranchData = branch.data
                    },
                    .default(Text("Compare")) {
                        compareBranchA = branch
                    },
                    .destructive(Text("Delete")) {
                        recipe.deleteBranch(branch: branch)
                    },
                    .cancel()
                ]
            )
        }
        .sheet(item: $editBranch) { branch in
            NavigationView {
                EditBranchView(branchData: $newBranchData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        newBranchData = RecipeBranch.Data()
                        editBranch = nil
                    }, trailing: Button("Save") {
                        let myBranch = binding(for: branch)
                        myBranch.wrappedValue.update(name: newBranchData.name)
                        editBranch = nil
                        newBranchData = RecipeBranch.Data()
                    })
                    .navigationTitle("Editing: \(branch.name)")
            }
        }
        .sheet(isPresented: $newBranchIsPresented) {
            NavigationView {
                NewBranchView(recipe: recipe, branchData: $newBranchData, selectedBranchIndex: $selectedBranchIndex)
                    .navigationBarItems(leading: Button("Dismiss") {
                        newBranchIsPresented = false
                    }, trailing: Button("Add") {
                        newBranchData.root = recipe.branches[selectedBranchIndex].head
                        let newBranch = recipe.createBranch(from: newBranchData)
                        recipe.setCurrentBranch(branch: newBranch)
                        newBranchIsPresented = false
                        actionBranch = nil
                    })
            }
        }
        .sheet(isPresented: .constant(compareBranchA != nil)) {
            NavigationView {
                CompareVersionsView(
                    recipe: recipe,
                    versionA: compareBranchA!.head
                )
                .navigationBarItems(leading: Button("Dismiss") {
                    compareBranchA = nil
                })
            }
        }
    }
    
    private func binding(for branch: RecipeBranch) -> Binding<RecipeBranch> {
        guard let branchIndex = recipe.branches.firstIndex(of: branch) else {
            fatalError("Can't find Branch in Recipe")
        }
        return $recipe.branches[branchIndex]
    }
}

struct EditRecipeBranchView_Previews: PreviewProvider {
    static var previews: some View {
        BranchesView(recipe: .constant(Recipe.data[0]))
    }
}
