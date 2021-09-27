//
//  search.swift
//  Forking
//
//  Created by Matt de Young on 27.09.21.
//

import SwiftUI

struct searchBar: View {
    @Binding var text: String
    @State var isEditing = false
    var placeholder = "Search"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.ui.fieldBackgroundColor)
            TextField("", text: $text)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .foregroundColor(Color.ui.foregroundColor)
                .accentColor(Color.ui.accentColor)
                .font(Font.body.weight(.semibold))
                .padding(isEditing ? 8 : 2)
                .padding(.leading, 28)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.ui.foregroundColor, lineWidth: 2)
                )
                .animation(.default)
        }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(Color.ui.foregroundColor)
                        .padding(.leading, 8)
                    if isEditing {
                        Button(action: {
                            isEditing = false
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil
                            )
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Color.ui.accentColor)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .onTapGesture {
                isEditing = true
            }
    }
}

struct search_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            searchBar(text: .constant("Testing"), isEditing: true)
        }
        Form {
            searchBar(text: .constant(""))
        }
    }
}
