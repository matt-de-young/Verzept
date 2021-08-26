//
//  ListBranchesView.swift
//  Forking
//
//  Created by Matt de Young on 25.08.21.
//

import CoreData
import SwiftUI

struct ListBranchesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var viewContext: NSManagedObjectContext
    @State var recipe: Recipe
    
    @State private var newBranchIsPresented: Bool = false
    @State private var selectedBranch: Branch? = nil
    @State private var editBranch: Branch? = nil
    @State private var CompareBranchIsPresented: Bool = false
    @State private var compareBranch: Branch? = nil

    var body: some View {
        List() {
            ForEach(Array(recipe.branches)) { branch in
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
                    selectedBranch = branch
                }
            }
//            .onDelete { indices in
//                withAnimation {
//                    recipe.branches.remove(atOffsets: indices)
//                }
//            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button(action: {
            newBranchIsPresented = true
        }) {
            Image(systemName: "plus")
        })
        .actionSheet(item: $selectedBranch, content: { branch in
            var buttons: [ActionSheet.Button] = [
                .default(Text("Edit")) {
                    editBranch = branch
                },
                .default(Text("Compare")) {
                    compareBranch = branch
                    CompareBranchIsPresented = true
                },
                .cancel()
            ]
            if (branch != recipe.currentBranch) {
                buttons.append(contentsOf: [
                    .default(Text("Make Current").bold()) {
                        Recipe.setCurrentBranch(context: viewContext, recipe: recipe, branch: branch)
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    .destructive(Text("Delete")) {
                        withAnimation {
                            Recipe.deleteBranch(context: viewContext, recipe: recipe, branch: branch)
                        }
                    }
                ])
            }
            return ActionSheet(
                title: Text("\(branch.name)"),
                message: Text("Last updated \(Text(branch.head.created, style: .relative)) ago"),
                buttons: buttons
            )
        })
        .sheet(isPresented: $newBranchIsPresented) {
            NewBranchView(branches: Array(recipe.branches)) { basedOn, name in
                Recipe.addBranch(context: viewContext, recipe: recipe, name: name, basedOn: basedOn)
                newBranchIsPresented = false
                selectedBranch = nil
            }
        }
        .sheet(item: $editBranch) { branch in
            EditBranchView(name: branch.name) { name in
                Branch.update(context: viewContext, branch: branch, name: name)
                editBranch = nil
            }
        }
        .background(
            NavigationLink(
                destination: CompareBranchesView(
                    branchA: compareBranch ?? recipe.currentBranch,
                    branches: Array(recipe.branches).filter { $0 != compareBranch }
                ),
                isActive: $CompareBranchIsPresented
            ) {
                EmptyView()
            }
        )
    }
}

struct ListBranchesView_Previews: PreviewProvider {
    static var previews: some View {
        ListBranchesView(
            viewContext: PersistenceController.preview.container.viewContext,
            recipe: Recipe(
                context: PersistenceController.preview.container.viewContext,
                title: "Super Recipe",
                ingredients: [],
                directions: "",
                notes: []
            )
        )
    }
}
