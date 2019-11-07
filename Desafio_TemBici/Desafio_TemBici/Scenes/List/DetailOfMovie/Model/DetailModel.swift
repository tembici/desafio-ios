//
//  DetailModel.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class DetailModel {
    
    var movieName: String
    var movieImage: UIImage
    var movieDate: String
    var movieGenre: [Genre]
    var movieOverview: String
    
    init(movieName: String, movieImage: UIImage, movieDate: String, movieGenre: [Genre], movieOverview: String) {
        self.movieName = movieName
        self.movieImage = movieImage
        self.movieDate = movieDate
        self.movieGenre = movieGenre
        self.movieOverview = movieOverview
    }
    
    func getGenres() -> String {
        var genres: [String] = []
        
        for genre in movieGenre {
            genres.append(genre.name)
        }
        
        if genres.count == 0 {
            return ""
        } else {
            if genres.count != 1 {
                return genres.joined(separator: ", ")
            } else {
                if let genre = genres.first {
                    return genre
                }
            }
        }
        return ""
    }
    
    func getDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"

        if let date = dateFormatterGet.date(from: movieDate) {
            return dateFormatterPrint.string(from: date)
        } else {
           return ""
        }
    }
    
}
