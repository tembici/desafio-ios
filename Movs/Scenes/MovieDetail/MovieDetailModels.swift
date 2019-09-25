//
//  MovieDetailModels.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

enum MovieDetail {
    
    // MARK: Use cases
    
    enum FetchMovieDetails {
        struct Request {
            var movieId: Int
        }
        struct Response {
            var movie: Movie?
        }
        struct ViewModel {
            var movieTitle: String
            var moviePosterUrl: String
            var movieRate: String
            var movieOverview: String
            var movieReleaseYear: String
            var movieLength: String
            var movieLanguage: String
        }
    }
    
    enum FetchMovieVideos {
        struct Request {
            var movieId: Int
        }
        struct Response {
            var content: [Any]?
        }
        struct ViewModel {
            var content: [Any]
        }
    }
    
}
