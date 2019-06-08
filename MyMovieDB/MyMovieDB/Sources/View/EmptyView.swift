//
//  EmptyView.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 08/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

class EmptyView: UIView, NibBounded {
    
    @IBOutlet weak var lblMenssage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(hugsContent: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(hugsContent: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(menssage: String) {
        lblMenssage.text = menssage
    }
}
