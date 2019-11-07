//
//  FavoriteModel.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class FavoriteModel {
    
    let movieImage: UIImage
    let movieName: String
    let movieDate: String
    let movieOverview: String
    
    init(movieName: String, movieImage: UIImage, movieDate: String, movieOverview: String) {
        self.movieName = movieName
        self.movieImage = movieImage
        self.movieDate = movieDate
        self.movieOverview = movieOverview
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
