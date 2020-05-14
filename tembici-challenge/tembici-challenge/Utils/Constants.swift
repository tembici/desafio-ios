//
//  Constants.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation


struct Constants {
    
    struct API {
        static let theMoviedbApiUrl = "https://api.themoviedb.org/3/"
        static let movieAPIKey = "43ad0db4f3070a48b50eabb210ae8c09"
        static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    }
    struct Design {
        struct Color {
            static let Gold = "gold"
            static let Yellow = "yellow"
            static let Gray = "gray"
            static let White = "white"
            
            
        }
        struct Font {
            static let HelveticaNeueThin = "HelveticaNeue-Thin"
            static let Farah = "Farah"
            static let Thonburi = "Thonburi"
        }
        
    }
    enum ImageType  {
        case bigPoster
        case smallPoster
        case backdrop
        
    }
}
