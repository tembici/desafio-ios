//
//  MovieDisplay.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

struct MovieDisplay{
    
    var id: Int?
    var thumb: UIImage?
    var title: String?
    var favorite: Bool?
    
    init(id: Int, thumb: UIImage, title: String, favorite: Bool) {
        self.id = id
        self.thumb = thumb
        self.title = title
        self.favorite = favorite
    }
}
