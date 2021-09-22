//
//  Color.swift
//  Forking
//
//  Created by Matt de Young on 20.09.21.
//

import Foundation
import SwiftUI

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let accentColor = Color("AccentColor")
        let foregroundColor = Color("ForegroundColor")
        let backgroundColor = Color("BackgroundColor")
        let fieldBackgroundColor = Color("FieldBackgroundColor")
        
        let bodyColor = Color("ForegroundColor")
        let headerColor = Color("HeaderColor")
    }
}

struct TextButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.ui.accentColor : Color.ui.accentColor)
            .font(Font.body.weight(.semibold))
    }
}

struct DismissTextButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.ui.accentColor : Color.ui.accentColor)
            .font(Font.body.weight(.regular))
    }
}

struct SectionHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font(UIFont(name: "Futura Bold", size: 14)!))
            .textCase(.uppercase)
            .foregroundColor(Color.ui.headerColor)
            .padding(.bottom, 1)
    }
}

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
