//
//  MovieModel.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class MovieModel {
    
    var movieName: String
    var movieImage: UIImage
    var movieIsFavorited: Bool
    
    init(movieName: String, movieImage: UIImage, movieIsFavorited: Bool = false) {
        self.movieName = movieName
        self.movieImage = movieImage
        self.movieIsFavorited = movieIsFavorited
    }
    
}
