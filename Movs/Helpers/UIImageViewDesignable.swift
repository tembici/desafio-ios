//
//  UIImageViewDesignable.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageViewDesignable: UIImageView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
