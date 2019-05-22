//
//  TitleTableViewCell.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol TitleTableViewCellDelegate {
    
    func favoriteButtonClicked()
}

final class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: TitleTableViewCellDelegate?
    
    var favorite: Bool?
    
    func configure(info: String, favorite: Bool){
        
        infoLabel.text = info
        self.favorite = favorite
        
        let icon = favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_empty_icon")
        favoriteButton.setImage(icon, for: .normal)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        guard let favorite = self.favorite else{
            return
        }
        let icon = !favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_empty_icon")
        self.favorite = !favorite
        favoriteButton.setImage(icon, for: .normal)
        self.delegate?.favoriteButtonClicked()
    }
    
}
