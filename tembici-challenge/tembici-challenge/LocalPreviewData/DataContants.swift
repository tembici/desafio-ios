//
//  DataContants.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

///class responsible for providing static data for use in preview
class DataContants {
    static let sharedInstance = DataContants()
    let urlImage =  #"\/f4aul3FyD3jv3v4bul1IrkWZvzq.jpg"#
    
    let movieModelPreview = Movie(popularity: 140.588, voteCount: 1251, video: false, posterPath:  #"\/f4aul3FyD3jv3v4bul1IrkWZvzq.jpg"#, id: 10, adult: false, backdropPath: #"\/xFxk4vnirOtUxpOEWgA1MCRfy6J.jpg"#, originalLanguage: "en", originalTitle: "Onward", genreIDS:  [
        12,
        16,
        35,
        14,
        10751
    ], title: "Onward", voteAverage: 8, overview: "In a suburban fantasy world, two teenage elf brothers embark on an extraordinary quest to discover if there is still a little magic left out there.", releaseDate: "2020-02-29")
}
