//
//  CompareBranchesView.swift
//  Forking
//
//  Created by Matt de Young on 26.08.21.
//

import SwiftUI

struct CompareBranchesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var branchA: Branch
    var branches: [Branch]
    @State var branchB: Branch?
    
    @State private var pickerBranchIndex = 0
    
    var body: some View {
        List() {
            Section(
                header: Text(branchA.name)
            ) {
                ForEach(Array(branchA.head.ingredients), id: \.self) { ingredient in
                    HStack {
                        Text("\(ingredient.quantity)")
                        Text(ingredient.unit)
                        Text(ingredient.name)
                    }
                }
                Text(branchA.head.directions)
            }
            if (branchB == nil) {
                Section(header: Text("Compare to branch")) {
                    Picker("Branch", selection: $pickerBranchIndex, content: {
                        ForEach(0..<branches.count, content: { index in
                            Text(branches[index].name)
                        })
                    })
                    .pickerStyle(WheelPickerStyle())
                    HStack {
                        Spacer()
                        Button("Compare") {
                            branchB = branches[pickerBranchIndex]
                        }
                    }
                }
            } else {
                Section(
                    header: Text(branchB!.name)
                ) {
                    ForEach(Array(branchB!.head.ingredients), id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.quantity)")
                            Text(ingredient.unit)
                            Text(ingredient.name)
                        }
                    }
                    Text(branchB!.head.directions)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct CompareBranchesView_Previews: PreviewProvider {
    static var viewContext = PersistenceController.preview.container.viewContext
    static var initVersion = Version(
        context: viewContext,
        name: "init",
        ingredients: [
            Ingredient(context: viewContext, name: "Stuff", quantity: "1", unit: "cup"),
            Ingredient(context: viewContext, name: "Other Stuff", quantity: "30", unit: "ml"),
        ],
        directions: "Mix the stuff into the other stuff."
    )
    static var otherVersion = Version(
        context: viewContext,
        name: "init",
        ingredients: [
            Ingredient(context: viewContext, name: "Stuff", quantity: "1", unit: "cup"),
            Ingredient(context: viewContext, name: "Other Stuff", quantity: "45", unit: "ml"),
        ],
        directions: "Fold the other stuff into the  stuff."
    )
    static var branchA = Branch(
        context: viewContext,
        name: "main",
        root: initVersion,
        head: initVersion
    )
    static var branchB = Branch(
        context: viewContext,
        name: "Try Folding",
        root: initVersion,
        head: otherVersion
    )
    static var previews: some View {
        CompareBranchesView(
            branchA: branchA,
            branches: [branchB]
        )
        CompareBranchesView(
            branchA: branchA,
            branches: [branchB],
            branchB: branchB
        )
    }
}
