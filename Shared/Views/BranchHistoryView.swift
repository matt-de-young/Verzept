//
//  BranchHistoryView.swift
//  Forking
//
//  Created by Matt de Young on 30.08.21.
//

import SwiftUI
import CoreData

struct BranchHistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    var branch: Branch
    
    var body: some View {
        Container {
            ItemList {
                ForEach(Array(branch.fullHistory())) { version in
                    NavigationLink(destination: VersionView(viewContext: viewContext, version: version)) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(version.name)
                                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                                        .foregroundColor(Color.ui.headerColor)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text(version.created, style: .date)
                                    Spacer()
                                }
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                                .font(Font.body.weight(.semibold))
                                .foregroundColor(Color.ui.accentColor)
                        }
                    }.modifier(ListItem())
                }
            }
        }
        .navigationTitle("History")
    }
}

struct BranchHistoryView_Previews: PreviewProvider {
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
        name: "More other stuff",
        ingredients: """
            1 cup Stuff
            45 ml Other Stuff
            """,
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
        NavigationView {
            BranchHistoryView(
                viewContext: viewContext,
                branch: branch
            )
        }
    }
}
