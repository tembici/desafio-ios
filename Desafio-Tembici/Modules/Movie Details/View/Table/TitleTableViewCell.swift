//
//  TitleTableViewCell.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol TitleTableViewCellDelegate{
    
    func favoriteIconClicked()
}

final class TitleTableViewCell: MovieDetailTableViewCell {

    var delegate: TitleTableViewCellDelegate?
    
    var favoriteIcon: UIButton!
    
    var favorite: Bool?
    
    public override func configure(detail: String) {
        super.configure(detail: detail)
        
        self.favoriteIcon = UIButton(frame: CGRect(x: self.bounds.width * 0.4, y: self.bounds.height * 0.5, width: self.bounds.height, height: self.bounds.width))
        
        guard let favorite = self.favorite else{ return }
        
        let imageIcon = favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_empty_icon")
        
        self.favoriteIcon.setImage(imageIcon, for: .normal)
        self.favoriteIcon.addTarget(self, action: #selector(self.favoriteIconClicked), for: .touchUpInside)
        self.addSubview(favoriteIcon)
    }
    
    @objc func favoriteIconClicked(){
    
        self.delegate?.favoriteIconClicked()
    }
}
