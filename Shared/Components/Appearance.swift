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
        let foregreoundColor = Color("ForegroundColor")
        let backgroundColor = Color("BackgroundColor")
        
        let bodyColor = Color("ForegreoundColor")
        let headerColor = Color("HeaderColor")
    }
}

struct TextButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.ui.accentColor : Color.ui.accentColor)
    }
}

struct SectionHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
    }
}

struct formLabel: ViewModifier {
    let font = Font.system(size: 12).weight(.black)
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.ui.foregreoundColor)
            .font(font)
    }
}
