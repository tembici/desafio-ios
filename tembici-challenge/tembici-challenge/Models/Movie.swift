//
//  Movie.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies:  Hashable, Codable {
    let page, totalResults, totalPages: Int
    let moviesList: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case moviesList = "results"
    }
}


// MARK: - Result
struct Movie: Hashable, Codable, Identifiable {
    var posterPath: String?
    var id: Int
    var backdropPath: String?
    var genreIDS: [Int]
    var title: String
    var voteAverage: Double
    var overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(movie: Favorite) {
        self.id = movie.id
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.genreIDS = Array(movie.genreIDS)
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
    }
    init(id: Int, posterPath: String ,backdropPath: String, genreIDS:[Int], title:String, voteAverage: Double, overview:String, releaseDate:String) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

