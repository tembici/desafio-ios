//
//  UICollectionView+Extension.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.identifier, bundle: nil) }
}

extension UICollectionView {
    
    func register(_ cellType: UICollectionViewCell.Type) {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
}
