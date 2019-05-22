//
//  MovieDetailsPresenterBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MovieDetailsPresenterBuilder{
    
    static func make(wireframe: MovieDetailsWireframe, movie: MovieEntity) -> MovieDetailsPresenter{
        
        let interactor = MovieDetailsInteractorBuilder.make(movie: movie)
        let presenter = MovieDetailsPresenter(wireframe: wireframe)
        
        presenter.interactor = interactor
        interactor.output = presenter
        
        return presenter
    }
}
