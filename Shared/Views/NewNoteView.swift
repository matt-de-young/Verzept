//
//  NewNoteView.swift
//  Forking
//
//  Created by Matt de Young on 25.08.21.
//

import SwiftUI

struct NewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var text: String = ""
    let onComplete: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note")) {
                    TextEditor(text: $text)
                        .frame(minHeight: 200.0)
                }
            }
            .navigationBarItems(
                leading: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.body.weight(.regular)),
                trailing: Button("Add") {
                    onComplete(text)
                }
            )
            .navigationTitle("Add Note")
        }
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView() { text in
            
        }
    }
}
