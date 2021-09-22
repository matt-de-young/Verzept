//
//  VersionView.swift
//  Forking
//
//  Created by Matt de Young on 31.08.21.
//

import SwiftUI
import CoreData

struct VersionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var viewContext: NSManagedObjectContext
    @ObservedObject var version: Version
    @State private var newBranchIsPresented = false
    @State var newBranchName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if !version.ingredients.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Ingrdients:").font(.headline)
                    IngredientListView(ingredients: version.ingredients)
                })
                .padding(.bottom)
            }
            
            if !version.directions.isEmpty {
                VStack(alignment: .leading, content: {
                    Text("Directions:").font(.headline)
                    Text(version.directions)
                })
                .padding(.bottom)
            }
            
            if !version.notes.isEmpty {
                Text("Notes:").font(.headline)
                ForEach(Array(version.notes), id: \.self) { note in
                    VStack(alignment: .leading) {
                        Text(note.created, style: .date)
                            .fontWeight(.light)
                            .font(.system(size: 12))
                        Text(note.text)
                    }
                    .padding(.bottom)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle(version.name)
        .navigationBarItems(trailing: Button(action: {
            newBranchIsPresented = true
        }) {
            Text("Branch")
            Image(systemName: "arrow.branch")
        })
        .sheet(isPresented: $newBranchIsPresented, content: {
            NavigationView {
                ZStack {
                    Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 8) {
                            FormField(text: $newBranchName, header: "Name")
                            Spacer()
                        }
                        .padding()
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
        VersionView(viewContext: viewContext, version: initVersion)
    }
}
