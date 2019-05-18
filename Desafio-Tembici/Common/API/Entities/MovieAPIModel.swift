//
//  MovieAPIModel.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import ObjectMapper

final class MovieAPIModel: Mappable{
    
    var title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.poster_path <- map["poster_path"]
        self.release_date <- map["release_date"]
        self.overview <- map["release_date"]
    }
}
