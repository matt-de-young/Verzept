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
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    FormField(text: $text, header: "Note", isMultiLine: true)
                    Spacer()
                }
                .padding()
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
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewNoteView() { text in
                
            }
        }
    }
}
