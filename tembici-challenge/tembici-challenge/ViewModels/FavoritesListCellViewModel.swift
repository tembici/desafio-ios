//
//  MoviesListCellViewModel.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class  FavoritesListCellViewModel: ObservableObject {
   
    @Published var urlImage = String()
    @Published var voteAverage = 0
    @Published var title = String()
    @Published var overView = String()
    @Published var date = String()
    @Published var id: Int = 0
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
        self.setUrlImage()
        self.setMovieID()
        self.setTitle()
        self.setDate()
        self.setVoteAverage()
      }
    
    fileprivate func setOverView() {
            self.overView = self.movie.overview
    }
    fileprivate func setTitle() {
               self.title = self.movie.title
       }
    fileprivate func setDate() {
        self.date = FormatterDate.getCompleteDate(dateString: movie.releaseDate)
    }
    fileprivate func setVoteAverage() {
        self.voteAverage = Int(self.movie.voteAverage * 10)
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
