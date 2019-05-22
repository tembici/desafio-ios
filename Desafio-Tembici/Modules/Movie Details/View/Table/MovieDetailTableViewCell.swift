//
//  MovieDetailTableViewCell.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    public func configure(detail: String){
        
        self.detailLabel.text = detail
    }
}
