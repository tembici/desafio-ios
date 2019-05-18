//
//  MoviesPresenter.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MoviesPresenterInput{
    
    func viewDidLoad()
    
    var output: MoviesPresenterOutput?{ get set}
}

protocol MoviesPresenterOutput: class{
    
}

final class MoviesPresenter: MoviesPresenterInput{
    
    var output: MoviesPresenterOutput?
    var interactor: MoviesInteractorInput?
    
    var movieItems: [MovieItem] = []
    
    func viewDidLoad() {
        
        self.interactor?.fetchMovies()
    }
}

extension MoviesPresenter: MoviesInteractorOutput{
    
    func fetchedMovies(movies: [MovieEntity]) {
        
    }
}
