//
//  ListBranchesView.swift
//  Forking
//
//  Created by Matt de Young on 25.08.21.
//

import CoreData
import SwiftUI

struct BranchListItem: View {
    var branch: Branch
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(branch.name)
                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                        .foregroundColor(Color.ui.headerColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(branch.head.name)
                        .foregroundColor(Color.ui.foregroundColor)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(branch.head.created, style: .date)
                        .foregroundColor(Color.ui.foregroundColor)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct ListBranchesView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var recipe: Recipe
    
    @State private var newBranchIsPresented: Bool = false
    @State private var selectedBranch: Branch? = nil
    @State private var editBranch: Branch? = nil
    @State private var compareBranchIsPresented: Bool = false
    @State private var compareBranch: Branch? = nil
    @State private var historyBranchIsPresented: Bool = false
    @State private var historyBranch: Branch? = nil

    var body: some View {
        Container {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Current").modifier(SectionHeader())
                        Spacer()
                    }
                    BranchListItem(branch: recipe.currentBranch)
                        .modifier(ListItem())
                        .onTapGesture {
                            selectedBranch = recipe.currentBranch
                        }
                }
                    .padding()
                VStack(spacing: 8) {
                    ForEach(Array(recipe.branches)) { branch in
                        if branch != recipe.currentBranch {
                            BranchListItem(branch: branch)
                                .modifier(ListItem())
                                .onTapGesture {
                                    selectedBranch = branch
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationBarItems(trailing: Button(action: {
                newBranchIsPresented = true
            }) {
                Image(systemName: "plus")
                    .font(Font.body.weight(.semibold))
                    .foregroundColor(Color.ui.accentColor)
            })
            .navigationTitle("Branches")
        }
        .actionSheet(item: $selectedBranch, content: { branch in
            var buttons: [ActionSheet.Button] = [
                .default(Text("Edit")) {
                    editBranch = branch
                },
                .default(Text("Compare")) {
                    compareBranch = branch
                    compareBranchIsPresented = true
                },
                .default(Text("View History")) {
                    historyBranch = branch
                    historyBranchIsPresented = true
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
                Recipe.addBranch(context: viewContext, recipe: recipe, name: name, root: basedOn.head)
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
                isActive: $compareBranchIsPresented
            ) {
                EmptyView()
            }
        )
        .background(
            NavigationLink(
                destination: BranchHistoryView(
                    branch: historyBranch ?? recipe.currentBranch
                ),
                isActive: $historyBranchIsPresented
            ) {
                EmptyView()
            }
        )
    }
}

struct ListBranchesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListBranchesView(
                recipe: Recipe(
                    context: PersistenceController.preview.container.viewContext,
                    title: "Super Recipe",
                    ingredients: "",
                    directions: "",
                    notes: []
                )
            )
        }
        .preferredColorScheme(.light)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        NavigationView {
            ListBranchesView(
                recipe: Recipe(
                    context: PersistenceController.preview.container.viewContext,
                    title: "Super Recipe",
                    ingredients: "",
                    directions: "",
                    notes: []
                )
            )
        }
        .preferredColorScheme(.dark)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
