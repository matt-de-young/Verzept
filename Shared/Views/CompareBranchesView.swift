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
                header: Text(branchA.name).modifier(FormLabel())
            ) {
                Text(branchA.head.ingredients)
                Text(branchA.head.directions)
            }
            if (branchB == nil) {
                Section(header: Text("Compare to branch").modifier(FormLabel())) {
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
                    header: Text(branchB!.name).modifier(FormLabel())
                ) {
                    Text(branchB!.head.ingredients)
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
        ingredients: """
            1 cup Stuff
            30 ml Other Stuff
            """,
        directions: "Mix the stuff into the other stuff."
    )
    static var otherVersion = Version(
        context: viewContext,
        name: "init",
        ingredients: """
            1 cup Stuff
            45 ml Other Stuff
            """,
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
