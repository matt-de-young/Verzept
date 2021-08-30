//
//  BranchHistoryView.swift
//  Forking
//
//  Created by Matt de Young on 30.08.21.
//

import SwiftUI

struct BranchHistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var branch: Branch
    
    var body: some View {
        List() {
            ForEach(Array(branch.fullHistory())) { version in
                HStack {
                    VStack(alignment: .leading) {
                        Text(version.name)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(version.created, style: .date)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                    }
                }.contentShape(Rectangle())
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct BranchHistoryView_Previews: PreviewProvider {
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
        name: "More other stuff",
        ingredients: [
            Ingredient(context: viewContext, name: "Stuff", quantity: "1", unit: "cup"),
            Ingredient(context: viewContext, name: "Other Stuff", quantity: "45", unit: "ml"),
        ],
        directions: "Fold the other stuff into the  stuff.",
        parent: initVersion
    )
    static var branch = Branch(
        context: viewContext,
        name: "Try Folding",
        root: initVersion,
        head: otherVersion
    )
    static var previews: some View {
        BranchHistoryView(
            branch: branch
        )
    }
}
