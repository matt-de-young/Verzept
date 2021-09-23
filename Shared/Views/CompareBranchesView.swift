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
        TextContainer {
            VStack(alignment: .leading) {
                Text(branchA.name)
                    .font(Font(UIFont(name: "Futura Bold", size: 36)!))
                    .textCase(.uppercase)
                    .foregroundColor(Color.ui.headerColor)
                    .padding(.bottom, 1)
                if !branchA.head.ingredients.isEmpty {
                    VStack(alignment: .leading, content: {
                        Text("Ingredients:").modifier(SectionHeader())
                        IngredientListView(ingredients: branchA.head.ingredients).font(Font.body.weight(.semibold))
                    })
                        .padding(.bottom)
                }
            
                if !branchA.head.directions.isEmpty {
                    VStack(alignment: .leading, content: {
                        Text("Directions:").modifier(SectionHeader())
                        DirectionsListView(directions: branchA.head.directions).font(Font.body.weight(.semibold))
                    })
                        .padding(.bottom)
                }
            }
            if (branchB == nil) {
                Text("Compare to branch")
                    .font(Font(UIFont(name: "Futura Bold", size: 36)!))
                    .textCase(.uppercase)
                    .foregroundColor(Color.ui.headerColor)
                    .padding(.bottom, 1)
                Form {
                    Picker("Branch", selection: $pickerBranchIndex, content: {
                        ForEach(0..<branches.count, content: { index in
                            Text(branches[index].name)
                        })
                    })
                    .pickerStyle(WheelPickerStyle())
                }
                HStack {
                    Spacer()
                    Button("Compare") {
                        branchB = branches[pickerBranchIndex]
                    }
                    .font(Font.body.weight(.semibold))
                    .foregroundColor(Color.ui.accentColor)
                }
            } else {
                VStack(alignment: .leading) {
                    Text(branchB!.name)
                        .font(Font(UIFont(name: "Futura Bold", size: 36)!))
                        .textCase(.uppercase)
                        .foregroundColor(Color.ui.headerColor)
                        .padding(.bottom, 1)
                    if !branchB!.head.ingredients.isEmpty {
                        VStack(alignment: .leading, content: {
                            Text("Ingredients:").modifier(SectionHeader())
                            IngredientListView(ingredients: branchB!.head.ingredients).font(Font.body.weight(.semibold))
                        })
                            .padding(.bottom)
                    }
                    
                    if !branchB!.head.directions.isEmpty {
                        VStack(alignment: .leading, content: {
                            Text("Directions:").modifier(SectionHeader())
                            DirectionsListView(directions: branchB!.head.directions).font(Font.body.weight(.semibold))
                        })
                            .padding(.bottom)
                    }
                }
            }
        }
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
