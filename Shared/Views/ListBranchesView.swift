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
                let isCurrentBranch = branch == recipe.currentBranch
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(branch.name).fontWeight(isCurrentBranch ? .heavy : .regular)
                            Spacer()
                            if isCurrentBranch {
                                Text("current")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.accentColor)
                            }
                        }
                        Spacer()
                        HStack {
                            Text(branch.head.name)
                                .fontWeight(isCurrentBranch ? .semibold : .light)
                                .font(.system(size: 12))
                            Spacer()
                            Text(branch.head.created, style: .date)
                                .fontWeight(isCurrentBranch ? .semibold : .light)
                                .font(.system(size: 12))
                        }
                    }
                }.contentShape(Rectangle())
                .onTapGesture {
                    selectedBranch = branch
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button(action: {
            newBranchIsPresented = true
        }) {
            Image(systemName: "plus")
        })
        .navigationTitle("Branches")
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
