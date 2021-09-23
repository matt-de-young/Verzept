//
//  Form.swift
//  Forking
//
//  Created by Matt de Young on 23.09.21.
//

import SwiftUI

struct Form<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    content
                    Spacer()
                }
                    .padding()
            }
        }
    }
}

struct Form_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FormField(text: .constant("Some Note text"), header: "Note", isMultiLine: true)
        }
    }
}
