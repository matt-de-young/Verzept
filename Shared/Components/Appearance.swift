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
            .font(Font.system(size: 12).weight(.black))
            .padding(.bottom, 1)
    }
}

struct formLabel: ViewModifier {
    let font = Font.system(size: 12).weight(.black)
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.ui.bodyColor)
            .font(font)
    }
}
