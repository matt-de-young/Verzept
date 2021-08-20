//
//  NewNoteView.swift
//  Forking
//
//  Created by Matt de Young on 20.08.21.
//

import SwiftUI

struct NewNoteView: View {
    @Binding var noteData: VersionNote.Data
    
    var body: some View {
        List {
            Section() {
                TextEditor(text: $noteData.text)
                    .frame(minHeight: 200.0)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(noteData: .constant(VersionNote.Data()))
    }
}
