//
//  NewBranchView.swift
//  Forking
//
//  Created by Matt de Young on 25.08.21.
//

import SwiftUI
import CoreData

struct NewBranchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var branches: [Branch]
    @State var name: String = ""
    @State private var selectedBranchIndex = 0
    let onComplete: (Branch, String) -> Void
    
    var body: some View {
        NavigationView {
            Container {
                Form {
                    FormField(text: $name, header: "Name")
                    HStack {
                        Text("Based on Branch")
                            .foregroundColor(Color.ui.headerColor)
                            .font(Font.system(size: 14).weight(.black))
                            .textCase(.uppercase)
                        Spacer()
                    }
                    Picker("Branch", selection: $selectedBranchIndex, content: {
                        ForEach(0..<branches.count, content: { index in
                            Text(branches[index].name)
                        })
                    })
                        .pickerStyle(WheelPickerStyle())
                }
                .navigationTitle("New Branch")
                .navigationBarItems(
                    leading: Button("Dismiss") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(DismissTextButton()),
                    trailing: Button("Create") {
                        onComplete(branches[selectedBranchIndex], name)
                    }.buttonStyle(TextButton())
                )
            }
        }
    }
}

struct NewBranchView_Previews: PreviewProvider {
    static var newVersion = Version(
        context: PersistenceController.preview.container.viewContext,
        name: "init",
        ingredients:"",
        directions: ""
    )
    static var previews: some View {
        NewBranchView(
            branches: [
                Branch(
                    context: PersistenceController.preview.container.viewContext,
                    name: "main",
                    root: newVersion,
                    head: newVersion
                )
            ]
        ) { name, basedOnBranch in
                
        }
    }
}
