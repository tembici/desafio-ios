//
//  MovieItem.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

struct MovieItem{
    
    var title: String?
    var thumb: String?
    var favorite: Bool?
    
    init(title: String, thumb: String, favorite: Bool){
        self.title = title
        self.thumb = thumb
        self.favorite = favorite
    }
}
