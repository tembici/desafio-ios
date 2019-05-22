//
//  FavoritesTableViewCell.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var display: FavoriteDisplay?
    
    public func configure(){
        
        thumb.image = display?.thumb
        titleLabel.text = display?.title
        sinopseLabel.text = display?.sinopse
        yearLabel.text = display?.year
    }
}
