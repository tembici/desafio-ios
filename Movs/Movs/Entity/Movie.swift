//
//  Movie.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    var id: Int
    var imageUrl: String?
    var posterImageUrl: String?
    var title: String?
    var overview: String?
    var release: String?
    var rate: Double?
    var genres: [Int]?
    var language: String?
    var movieLength: Int?
    var isFavorite: Bool? = false
    var category: Category = .topRated
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "poster_path"
        case posterImageUrl = "backdrop_path"
        case title
        case overview
        case release = "release_date"
        case rate = "vote_average"
        case genres = "genre_ids"
        case language = "original_language"
        case movieLength = "runtime"
    }
    
    enum Category: String {
        case topRated = "top_rated"
        case popular = "popular"
        case upcoming = "upcoming"
    }
}
