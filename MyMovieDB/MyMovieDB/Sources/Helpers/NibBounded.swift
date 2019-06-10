//
//  NibBounded.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 08/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

public protocol NibBounded: NibLoadableView {
    /**
     Loads the view from its standard nibName and adds it into the view hierarchy
     - parameter hugsContent: se true indica que a view se comportará com o tamanho do Xib.
     */
    func setupView( hugsContent: Bool)
}

extension NibBounded where Self: UIView {
    public func setupView( hugsContent: Bool) {
        let myClass = Self.self
        let bundle = Bundle(for: myClass)
        let view = bundle.loadNibNamed(myClass.nibName, owner: self, options: nil)?.first as! UIView
        if hugsContent {
            bounds = view.frame
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        else {
            view.frame = bounds
        }
        addSubview(view)
    }
}
