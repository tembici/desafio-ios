//
//  UIColor+Movs.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
    fileprivate static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    fileprivate static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return rgba(r, g, b, 1.0)
    }

    static let mvYellow = rgb(246, 199, 81)
    static let mvBlue = rgb(40, 42, 62)
    static let mvOrange = rgb(212, 140, 28)
    
}
