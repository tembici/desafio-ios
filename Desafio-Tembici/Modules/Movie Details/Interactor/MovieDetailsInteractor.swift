//
//  MovieDetailsInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MovieDetailsInteractorInput{
    
    var output: MovieDetailsInteractorOutput?{ get set}
    
    func fetchMovieDetails()
    func setFavorite()
}

protocol MovieDetailsInteractorOutput: class {
    
    func fetchedMovieDetails(movie: MovieEntity)
}

final class MovieDetailsInteractor: MovieDetailsInteractorInput{
    
    var output: MovieDetailsInteractorOutput?
    
    var movie: MovieEntity
    
    init(movie: MovieEntity) {
        self.movie = movie
    }
    
    func fetchMovieDetails() {
        
        self.output?.fetchedMovieDetails(movie: self.movie)
    }
    
    func setFavorite() {
        
    }
}
