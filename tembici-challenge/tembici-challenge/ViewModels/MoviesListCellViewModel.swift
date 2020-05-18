//
//  MoviesListCellViewModel.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class  MoviesListCellViewModel: ObservableObject {
   
    @Published var urlImage = String()
    @Published var title = String()
    @Published var date = String()
    @Published var id: Int = 0
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
        self.setUrlImage()
        self.setMovieID()
        self.setTitle()
        self.setDate()
      }
    
    fileprivate func setTitle() {
            self.title = self.movie.title
    }
    fileprivate func setDate() {
        self.date = FormatterDate.getYear(dateString: movie.releaseDate)
    }
    fileprivate func setUrlImage() {
           if let poster = self.movie.posterPath {
               self.urlImage = poster
           }
       }
    
    fileprivate func setMovieID() {
        self.id = self.movie.id
    }
}
