//
//  ItemList.swift
//  Forking
//
//  Created by Matt de Young on 27.09.21.
//

import SwiftUI

struct ListItem: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.ui.fieldBackgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.ui.foregroundColor, lineWidth: 2)
            )
    }
}


struct ItemList<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                content
                Spacer()
            }
            .padding()
        }
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        Container {
            ItemList {
                HStack {
                    Text("My Item")
                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                        .foregroundColor(Color.ui.headerColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(Color.ui.accentColor)
                }
                .modifier(ListItem())
                HStack {
                    Text("Other Item")
                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                        .foregroundColor(Color.ui.headerColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(Color.ui.accentColor)
                }
                .modifier(ListItem())
                HStack {
                    Text("Last Item")
                        .font(Font(UIFont(name: "Futura Bold", size: 22)!))
                        .foregroundColor(Color.ui.headerColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(Color.ui.accentColor)
                }
                .modifier(ListItem())
            }
        }
    }
}
