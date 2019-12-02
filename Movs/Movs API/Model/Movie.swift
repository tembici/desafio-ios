//
//  Movie.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie: Codable {
    
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var backdropPath: String
    var posterPath: String
    var releaseDate: String
    var title: String
    var voteAverage: Double
    var voteCount: Int
    var genres: [String]
    var favorite: Bool
    
    init(
        backdropPath: String? = "",
        id: Int? = 0,
        originalLanguage: String? = "",
        originalTitle: String? = "",
        overview: String? = "",
        posterPath: String? = "",
        releaseDate: String? = "",
        title: String? = "",
        voteAverage: Double? = 0.0,
        voteCount: Int? = 0,
        genres: [String] = [],
        favorite: Bool? = false
        ) {
        self.backdropPath = backdropPath!
        self.id = id!
        self.originalLanguage = originalLanguage!
        self.originalTitle = originalTitle!
        self.overview = overview!
        self.posterPath = posterPath!
        self.releaseDate = releaseDate!
        self.title = title!
        self.voteAverage = voteAverage!
        self.voteCount = voteCount!
        self.genres = genres
        self.favorite = favorite!
    }
    
    init(with jsonResult: JSON) {
        self.backdropPath = jsonResult["backdrop_path"].string!
        self.id = jsonResult["id"].int!
        self.originalLanguage = jsonResult["original_language"].string!
        self.originalTitle =  jsonResult["original_title"].string!
        self.overview = jsonResult["overview"].string!
        self.posterPath = jsonResult["poster_path"].string!
        self.releaseDate = jsonResult["release_date"].string!
        self.title = jsonResult["title"].string!
        self.voteAverage = jsonResult["vote_average"].double!
        self.voteCount = jsonResult["vote_count"].int!
        self.genres = []
        for item in jsonResult["genres"] {
            self.genres.append(item.1["name"].string!)
        }
        
        self.favorite = true
//        self.favorite = QUERY DATABASE
    }
}
