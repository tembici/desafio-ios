//
//  Favorite.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import RealmSwift

class Favorite: Object {
    @objc dynamic var id = 0
    @objc dynamic var posterPath = ""
    @objc dynamic var backdropPath = ""
    var genreIDS = List<Int>()
    @objc dynamic var title = ""
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var releaseDate = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(movie: Movie) {
        self.init()
        
        self.id = movie.id
        self.posterPath = movie.posterPath ?? ""
        self.backdropPath = movie.backdropPath ?? ""
        self.genreIDS.append(objectsIn: movie.genreIDS)
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate

    }
}
