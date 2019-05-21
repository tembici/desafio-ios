//
//  MovieDetailsItem.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

struct MovieDetailsItem{
    
    var title: String?
    var posterImage: Data?
    var sinopse: String?
    var releaseYear: String?
    var favorite: Bool?
    
    init(title: String, posterImage: Data, sinopse: String, releaseYear: String, favorite: Bool) {
        
        self.title = title
        self.posterImage = posterImage
        self.sinopse = sinopse
        self.releaseYear = releaseYear
        self.favorite = favorite
    }
}
