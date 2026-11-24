//
//  AppFont.swift
//  Coop App
//
//  Created by John Gabriel on 24/11/2026.
//

import SwiftUI

// MARK: - Define app custom fonts

enum AppFont: String {
    case productSansBold = "ProductSans-Bold"
    case productSansLight = "ProductSans-Light"
    case productSansMedium = "ProductSans-Medium"
    case productSansRegular = "ProductSans-Regular"
}

// MARK: - Create a font helper to pass to Text

extension Font {
    static func appFont(_ font: AppFont, size: CGFloat) -> Font {
        return .custom(font.rawValue, size: size)
    }
}

// MARK: - Add View extension

extension View {
    func appFont(_ font: AppFont, size: CGFloat) -> some View {
        self.modifier(AppFontModifier(font: font, size: size))
    }
}

// MARK: - Create an App Font ViewModifier

struct AppFontModifier: ViewModifier {
    let font: AppFont
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.appFont(font, size: size))
    }
}
