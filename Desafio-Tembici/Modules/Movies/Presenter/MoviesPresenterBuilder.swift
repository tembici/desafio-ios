//
//  MoviesPresenterBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MoviesPresenterBuilder{
    
    static func make(wireframe: MoviesWireframe) -> MoviesPresenter{
        
        let interactor = MoviesInteractorBuilder.make()
        let presenter = MoviesPresenter(wireframe: wireframe)
        
        presenter.interactor = interactor
        interactor.output = presenter
        
        return presenter
    }
}
