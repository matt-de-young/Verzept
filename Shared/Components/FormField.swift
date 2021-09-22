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
    
    var body: some View {
        VStack {
            if header != nil {
                HStack {
                    Text(header!)
                        .foregroundColor(Color.ui.headerColor)
                        .font(Font.system(size: 14).weight(.black))
                        .textCase(.uppercase)
                    Spacer()
                }
            }
            if isMultiLine {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.ui.fieldBackgroundColor)
                    TextEditor(text: $text)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .frame(minHeight: 200.0)
                        .foregroundColor(Color.ui.foregroundColor)
                        .accentColor(Color.ui.accentColor)
                        .font(Font.body.weight(.semibold))
                        .padding(.leading, 2)
                        .padding(.trailing, 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.ui.foregroundColor, lineWidth: 2)
                        )
                    Text(text)
                        .opacity(0)
                        .padding(.all, 12)
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.ui.fieldBackgroundColor)
                    TextField("", text: $text)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .foregroundColor(Color.ui.foregroundColor)
                        .accentColor(Color.ui.accentColor)
                        .font(Font.body.weight(.semibold))
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.ui.foregroundColor, lineWidth: 2)
                        )
                }
            }
        }.padding(.bottom)
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    FormField(text: .constant("No Header"))
                    FormField(text: .constant("test input"), header: "single line")
                    FormField(
                        text: .constant("longer test input"),
                        header: "multi line",
                        isMultiLine: true
                    )
                    Spacer()
                }.padding()
            }
        }.preferredColorScheme(.light)
        ZStack {
            Color.ui.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    FormField(text: .constant("No Header"))
                    FormField(text: .constant("test input"), header: "single line")
                    FormField(
                        text: .constant("longer test input"),
                        header: "multi line",
                        isMultiLine: true
                    )
                    Spacer()
                }.padding()
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
