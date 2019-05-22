//
//  FavoritesInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol FavoritesInteractorInput{
    
    weak var output: FavoritesInteractorOutput?{ get set}
}

protocol FavoritesInteractorOutput: class{
    
}

final class FavoritesInteractor: FavoritesInteractorInput{
    
    weak var output: FavoritesInteractorOutput?
    var manager: MoviesManager
    
    var movies: [MovieEntity] = []
    
    init(manager: MoviesManager){
        self.manager = manager
    }
}
