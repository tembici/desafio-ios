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
    
    var thumb: UIImage?
    var title: String?
    var favorite: Bool?
    
    init(thumb: UIImage, title: String, favorite: Bool) {
        self.thumb = thumb
        self.title = title
        self.favorite = favorite
    }
}
