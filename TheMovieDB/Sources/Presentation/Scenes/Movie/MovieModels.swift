//
//  MovieModels.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import UIKit.UIImage

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
                let poster: String
                let favorited: UIImage?
            }
            let displayedMovie: DisplayedMovie
        }
    }
    
    enum ToggleFavorite {
        struct Request {
        }
        struct Response {
            let isFavorited: Bool
        }
        struct ViewModel {
            let displayedFavorited: UIImage?
        }
    }
    
}
