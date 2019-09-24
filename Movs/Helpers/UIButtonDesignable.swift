//
//  UIButtonDesignable.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit


// MARK: - UIButtonDesignable -

@IBDesignable
class UIButtonDesignable: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    /// (0  - ScaleToFill / 1 - ScaleAspectFit/ 2 - ScaleAspectFit)
    @IBInspectable
    var imageContentMode: Int {
        get { return self.imageView?.contentMode.rawValue ?? 0 }
        set {
            if let mode = UIView.ContentMode(rawValue: newValue),
                self.imageView != nil {
                self.imageView?.contentMode = mode
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    var elevate: CGFloat = 0.0 {
        didSet {
            self.layer.shadowOpacity = 0.5
            self.layer.shadowColor =  UIColor.black.cgColor
            self.layer.shadowRadius = 3.0
            self.layer.shadowOffset = CGSize(width: 2, height: self.elevate)
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable
    var isCircle: Bool = false {
        didSet {
            if isCircle {
                self.cornerRadius = self.bounds.height / 2
            }
        }
    }
}
