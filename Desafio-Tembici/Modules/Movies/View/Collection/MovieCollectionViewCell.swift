//
//  MovieCollectionViewCell.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate{
    
    func favoriteButtonClicked(id: Int)
    func didSelect(id: Int)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movieId: Int?
    
    var delegate: MovieCollectionViewCellDelegate?
    
    var movieDisplay: MovieDisplay?
    
    func configure(){
        
        guard let favorite = movieDisplay?.favorite else{
            return
        }
        self.movieId = movieDisplay?.id
        self.movieButton.setImage(movieDisplay?.thumb, for: .normal)//movieDisplay?.thumb
        self.titleLabel.text = movieDisplay?.title
        
        let favoriteButtonImage = favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_empty_icon")
        self.favoriteButton.setImage(favoriteButtonImage, for: .normal)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        guard let id = self.movieId,
              let favorite = movieDisplay?.favorite else{
            return
        }
        
        if favorite{
            self.favoriteButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        }
        else{
            self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        movieDisplay?.favorite = !favorite
        self.delegate?.favoriteButtonClicked(id: id)
    }
    
    @IBAction func movieButtonClicked(_ sender: Any) {
        
        guard let id = self.movieId else{
            return
        }
        self.delegate?.didSelect(id: id)
    }
    
}
