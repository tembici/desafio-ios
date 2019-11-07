
//
//  ListCell.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieIsFavorited: UIImageView!
    
    //MARK: PROPERTIES
    var movieModel: MovieModel? {
        didSet {
            guard let movieModel = movieModel else { return }
            movieImage.image = movieModel.movieImage
            movieName.text = movieModel.movieName
            
            if movieModel.movieIsFavorited {
                movieIsFavorited.image = #imageLiteral(resourceName: "favorite_full_icon")
            } else {
                movieIsFavorited.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }
        }
    }
    
}
