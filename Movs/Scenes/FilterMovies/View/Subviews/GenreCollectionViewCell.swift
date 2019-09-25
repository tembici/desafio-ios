//
//  GenreCollectionViewCell.swift
//  Rappi
//
//  Created by Miguel Pimentel on 02/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var cardView: UIViewDesignable!
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            self.highlightCard(isSelected: isSelected)
        }
    }
    
    func setup(with content: Any) {
        if let genre = content as? Genre {
            self.genreNameLabel.text = genre.name
        }
    }
    
    private func highlightCard(isSelected: Bool) {
        if isSelected {
            UIView.animate(withDuration: 1.0) {
                self.genreNameLabel.textColor = UIColor(named: "primaryYellow")
                self.genreNameLabel.font = UIFont.getExoFont(type: .semiBold, with: 21)
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.genreNameLabel.textColor = UIColor(named: "primaryGray")
                self.genreNameLabel.font = UIFont.getExoFont(type: .medium, with: 17)
            }
        }
    }

}
