//
//  FilterButtonCVH.swift
//  Movs
//
//  Created by lordesire on 27/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class FilterButtonCVH : UICollectionReusableView {
    
    //properties:
    @IBOutlet var btnFilter : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupLayout(target : Any?, action: Selector) {
        
        self.layoutIfNeeded()
        
        self.backgroundColor = App.Style.color2
        
        btnFilter.backgroundColor = App.Style.color2
        btnFilter.tintColor = App.Style.color1
        btnFilter.titleLabel?.text = "Remover Filtros"
        btnFilter.isExclusiveTouch = true
        //
        btnFilter.addTarget(target, action: action, for: .touchUpInside)
    }
    
    
}
