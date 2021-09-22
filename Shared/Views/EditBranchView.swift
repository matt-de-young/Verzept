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
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    FormField(text: $name, header: "Name")
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Edit Branch")
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.buttonStyle(DismissTextButton()),
                trailing: Button("Update") {
                    onComplete(name)
                }.buttonStyle(TextButton())
            )
        }
    }
}

struct EditBranchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditBranchView(name: "Sweet branch") { name in
                
            }
        }
    }
}
