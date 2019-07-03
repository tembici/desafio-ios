//
//  MovieModels.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum MovieModels {
    
    enum GetMovie {
        struct Request {
        }
        struct Response {
            let movie: Movie
        }
        struct ViewModel {
            struct DisplayedMovie {
                let title: String
                let year: String
                let genre: String
                let description: String
            }
            let displayedMovie: DisplayedMovie
        }
    }
    
}
