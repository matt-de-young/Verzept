//
//  VersionView.swift
//  Forking
//
//  Created by Matt de Young on 31.08.21.
//

import SwiftUI
import CoreData

struct VersionView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var version: Version
    @State private var newBranchIsPresented = false
    @State var newBranchName: String = ""
    
    var body: some View {
        TextContainer {
            if !version.ingredients.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Ingredients:").modifier(SectionHeader())
                    IngredientListView(ingredients: version.ingredients).font(Font.body.weight(.semibold))
                })
                    .padding(.bottom)
            }
            
            if !version.directions.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Directions:").modifier(SectionHeader())
                    DirectionsListView(directions: version.directions).font(Font.body.weight(.semibold))
                })
                    .padding(.bottom)
            }
            
            if !version.notes.isEmpty {
                Text("Notes:").modifier(SectionHeader())
                ForEach(Array(version.notes), id: \.self) { note in
                    VStack(alignment: .leading) {
                        Text(note.created, style: .date)
                            .fontWeight(.light)
                            .font(.system(size: 12))
                        Text(note.text).fontWeight(.semibold)
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle(version.name)
        .navigationBarItems(trailing: Button(action: {
            newBranchIsPresented = true
        }) {
            Text("Branch \(Image(systemName: "arrow.branch"))")
        }.buttonStyle(TextButton()))
        .sheet(isPresented: $newBranchIsPresented, content: {
            NavigationView {
                Form {
                    FormField(text: $newBranchName, header: "Name")
                }
                .navigationBarTitle(Text("New Branch"))
                .navigationBarItems(
                    leading: Button("Dismiss") {
                        newBranchIsPresented = false
                        newBranchName = ""
                    }.buttonStyle(DismissTextButton()),
                    trailing: Button("Create") {
                        Recipe.addBranch(
                            context: viewContext,
                            recipe: version.recipe,
                            name: newBranchName,
                            root: version
                        )
                        newBranchIsPresented = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(TextButton())
                    .disabled(self.newBranchName.isEmpty)
                )
            }
        })
    }
}

struct VersionView_Previews: PreviewProvider {
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
    static var previews: some View {
        NavigationView {
            VersionView(version: initVersion)
        }
    }
}
