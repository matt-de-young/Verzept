//
//  TextInput.swift
//  Forking
//
//  Created by Matt de Young on 21.09.21.
//

import SwiftUI

struct FormField: View {
    
    @Binding var text: String
    var header: String? = nil
    var isMultiLine = false
    
    struct CustomFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .foregroundColor(Color.ui.foregroundColor)
                .accentColor(Color.ui.accentColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            Color.ui.foregroundColor,
                            lineWidth: 1
                        )
                )
        }
    }
    
    struct InnerField: View {
        
        @Binding var text: String
        var isMultiLine = false
        
        var body: some View {
            if isMultiLine {
                ZStack {
                    TextEditor(text: $text)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .frame(minHeight: 200.0)
                        .foregroundColor(Color.ui.foregroundColor)
                        .accentColor(Color.ui.accentColor)
                        .font(Font.body.weight(.semibold))
                    Text(text)
                        .opacity(0)
                        .padding(.all, 8)
                }
            } else {
                TextField("", text: $text)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .foregroundColor(Color.ui.foregroundColor)
                    .accentColor(Color.ui.accentColor)
                    .font(Font.body.weight(.semibold))
            }
        }
    }
    
    var body: some View {
        if (header != nil) {
            Section(
                header: Text(header!)
                    .foregroundColor(Color.ui.headerColor)
                    .font(Font.system(size: 14).weight(.black))
                    .textCase(.uppercase)
            ) {
                InnerField(text: $text, isMultiLine: isMultiLine)
            }
        } else {
            Section {
                InnerField(text: $text, isMultiLine: isMultiLine)
            }
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            HStack() {
                VStack(alignment: .leading) {
                    Form {
                        FormField(text: .constant("No Header"))
                        FormField(text: .constant("test input"), header: "single line")
                        FormField(
                            text: .constant("longer test input"),
                            header: "multi line",
                            isMultiLine: true
                        )
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
