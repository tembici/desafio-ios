//
//  MovieEntity.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MovieEntity: NSObject{
    
    var title: String?
    var year: String?
    var sinopse: String?
    var thumb: String?
    
    init(title: String, year: String, sinopse: String, thumb: String){
        self.title = title
        self.year = year
        self.sinopse = sinopse
        self.thumb = thumb
    }
}
