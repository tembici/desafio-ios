//
//  MovieItem.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

struct MovieItem{
    
    var id: Int?
    var title: String?
    var thumb: String?
    var favorite: Bool?
    
    init(id: Int, title: String, thumb: String, favorite: Bool){
        self.id = id
        self.title = title
        self.thumb = thumb
        self.favorite = favorite
    }
}
