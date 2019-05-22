//
//  MovieDetailsPresenter.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterInput{
    
    var output: MovieDetailsPresenterOutput?{ get set}
    
    func viewDidLoad()
    func favoriteButtonClicked()
}

protocol MovieDetailsPresenterOutput: class{
    
    func loadDetailsUI(details: MovieDetailsItem)
}

final class MovieDetailsPresenter: MovieDetailsPresenterInput{
    
    weak var output: MovieDetailsPresenterOutput?
    var interactor: MovieDetailsInteractor?
    var wireframe: MovieDetailsWireframe
    
    var detailsItem: MovieDetailsItem?
    
    init(wireframe: MovieDetailsWireframe){
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        
        self.interactor?.fetchMovieDetails()
    }
    
    func favoriteButtonClicked() {
        
        self.interactor?.setFavorite()
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutput{
    
    func fetchedMovieDetails(movie: MovieEntity) {
        
        guard let movieItem = MovieDetailsMapper.make(from: movie) else{ return }
        
        self.detailsItem = movieItem
        
        self.output?.loadDetailsUI(details: movieItem)
    }
}
