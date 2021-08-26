//
//  EditBranchView.swift
//  Forking
//
//  Created by Matt de Young on 25.08.21.
//

import SwiftUI

struct EditBranchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Name")) {
                    TextField("", text: $name)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Edit Branch")
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.body.weight(.regular)),
                trailing: Button("Update") {
                    onComplete(name)
                }
            )
        }
    }
}

struct EditBranchView_Previews: PreviewProvider {
    static var previews: some View {
        EditBranchView(name: "Sweet branch") { name in
            
        }
    }
}
