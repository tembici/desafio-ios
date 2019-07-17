//
//  EmptySearchView.swift
//  Movs
//
//  Created by Ivan Ortiz on 17/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

class EmptySearchView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    var searchText:String? {
        didSet
        {
            lblTitle.text = "Search for \"\(searchText ?? "")\" returned no results."
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
