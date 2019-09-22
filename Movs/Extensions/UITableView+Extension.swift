//
//  UITableView+Extension.swift
//  Movs
//
//  Created by Miguel Pimentel on 22/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.identifier, bundle: nil) }
}

extension UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.identifier, bundle: nil) }
}

extension UITableView {
    
    func register(_ cellType: UITableViewCell.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func register(_ cellType: UITableViewHeaderFooterView.Type) {
        self.register(cellType.nib, forHeaderFooterViewReuseIdentifier: cellType.identifier)
    }
}

