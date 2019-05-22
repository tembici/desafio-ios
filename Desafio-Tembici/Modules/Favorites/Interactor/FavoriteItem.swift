//
//  FavoriteItem.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

struct FavoriteItem{
    
    var title: String
    var sinopse: String
    var year: String
    var thumb: Data
    
    init(title: String, sinopse: String, year: String, thumb: Data) {
        self.title = title
        self.sinopse = sinopse
        self.year = year
        self.thumb = thumb
    }
}
