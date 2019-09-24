//
//  UIFont+Extension.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

// MARK: - Extension UIFont -

extension UIFont {
    
    /// Get custom Exo font according to style and size
    ///
    /// - Parameters:
    ///   - type: type of font e.g(bold, semibold, medium, light, extralight)
    ///   - size: size of font
    /// - Returns: Exo font
    static func getExoFont(type: Exo, with size: CGFloat) -> UIFont {
        switch type {
        case .bold:
            return UIFont(name: Exo.bold.rawValue, size: size)!
        case .semiBold:
            return UIFont(name: Exo.semiBold.rawValue, size: size)!
        case .medium:
            return UIFont(name: Exo.medium.rawValue, size: size)!
        case .thin:
            return UIFont(name: Exo.thin.rawValue, size: size)!
        case .light:
            return UIFont(name: Exo.light.rawValue, size: size)!
        case .extraLight:
            return UIFont(name: Exo.extraLight.rawValue, size: size)!
        }
    }
    
    /// Typefaces for Exo font
    ///
    /// - bold: bold typeface
    /// - semiBold: semiBold typeface
    /// - medium: medium typeface
    /// - thin: thin typeface
    /// - light: light typeface
    /// - extraLight: extraLight typeface
    enum Exo: String {
        case bold = "Exo2-Bold"
        case semiBold = "Exo2-SemiBold"
        case medium = "Exo2-Medium"
        case thin = "Exo2-Thin"
        case light = "Exo2-Light"
        case extraLight = "Exo2-ExtraLight"
    }
}
