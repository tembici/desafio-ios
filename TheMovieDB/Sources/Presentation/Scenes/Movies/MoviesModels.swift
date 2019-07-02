//
//  MoviesModels.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum Movies {
    
    enum FetchMovies {
        struct Request {
        }
        struct Response {
            let movies: [Movie]
        }
        struct ViewModel {
            struct DisplayedMovie {
                let poster: String
                let title: String
                let isFavorited: Bool
            }
            let displayedMovies: [DisplayedMovie]
        }
    }

}
