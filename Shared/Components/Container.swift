//
//  Container.swift
//  Forking
//
//  Created by Matt de Young on 23.09.21.
//

import SwiftUI

struct Container<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            content
        }.foregroundColor(Color.ui.foregroundColor)
    }
}

struct TextContainer<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        Container {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    content
                    Spacer()
                }
            }.padding()
        }.foregroundColor(Color.ui.foregroundColor)
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container {
            Text("Some container ya got there.")
        }
        TextContainer {
            Text("Some Text Container ya got there.")
        }
    }
}
