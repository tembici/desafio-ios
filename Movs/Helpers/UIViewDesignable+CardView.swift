//
//  UIViewDesignable.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit


// MARK: - UIViewDesignable -

@IBDesignable
class UIViewDesignable: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}

// MARK: - CardView -

@IBDesignable
class CardView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private var corner: CGFloat = 5.0
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: corner).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadowLayer.shadowOpacity = 0.35
            shadowLayer.shadowRadius = 5
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

