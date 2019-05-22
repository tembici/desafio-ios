//
//  MovieDetailsViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MovieDetailsViewControllerBuilder{
    
    static func make(wireframe: MovieDetailsWireframe, movie: MovieEntity) -> MovieDetailsViewController{
        
        let presenter = MovieDetailsPresenterBuilder.make(wireframe: wireframe, movie: movie)
        let viewController = MovieDetailsViewController(nibName: String(describing: MovieDetailsViewController.self), bundle: nil)
        
        viewController.presenter = presenter
        presenter.output = viewController
        
        return viewController
    }
}

