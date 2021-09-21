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
        Form {
            Section(header: Text("Note").modifier(formLabel())) {
                TextEditor(text: $text)
                    .frame(minHeight: 200.0)
                    .foregroundColor(Color.ui.foregroundColor)
                    .accentColor(Color.ui.accentColor)
            }
        }
        .navigationBarItems(
            leading: Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }.buttonStyle(DismissTextButton()),
            trailing: Button("Add") {
                onComplete(text)
            }.buttonStyle(TextButton())
        )
        .navigationTitle("Add Note")
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView() { text in
            
        }
    }
}
