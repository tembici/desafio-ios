//
//  MovieEntity.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MovieEntity: NSObject{
    
    var id: Int?
    var title: String?
    var releaseDate: String?
    var sinopse: String?
    var thumb: String?
    var favorite: Bool = false
    
    init(id: Int, title: String, releaseDate: String, sinopse: String, thumb: String){
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.sinopse = sinopse
        self.thumb = thumb
    }
}
