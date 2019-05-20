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
    func favoriteButtonClicked(id: Int)
    func didSelect(id: Int)
    
    var output: MoviesPresenterOutput?{ get set}
}

protocol MoviesPresenterOutput: class{
    
    func loadUIMovies(items: [MovieItem])
}

final class MoviesPresenter: MoviesPresenterInput{
    
    var output: MoviesPresenterOutput?
    var interactor: MoviesInteractorInput?
    var wireframe: MoviesWireframe
    
    init(wireframe: MoviesWireframe){
        self.wireframe = wireframe
    }
    
    var movieItems: [MovieItem] = []
    
    func viewDidLoad() {
        
        self.interactor?.fetchMovies()
    }
    
    func favoriteButtonClicked(id: Int) {
        
        self.interactor?.setFavoriteMovie(id: id)
    }
    
    func didSelect(id: Int) {
        
        self.interactor?.findMovie(id: id)
    }
}

extension MoviesPresenter: MoviesInteractorOutput{
    
    func fetchedMovies(movies: [MovieEntity]) {
        
        self.movieItems = []
        
        for movie in movies{
            
            guard let item = MovieMapper.make(from: movie) else{
                return
            }
            self.movieItems.append(item)
        }
        print("movie Items",self.movieItems.count)
        self.output?.loadUIMovies(items: self.movieItems)
    }
    
    func foundMovie(_ movie: MovieEntity) {
        
        self.wireframe.presentDetails(for: movie)
    }
}
