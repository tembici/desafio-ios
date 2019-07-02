//
//  MoviesInteractor.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol MoviesInteractorProtocol {
    func didLoad()
}

protocol MoviesDataStore {
    
}

class MoviesInteractor: MoviesInteractorProtocol, MoviesDataStore {
    
    var presenter: MoviesPresenterProtocol?
    
    func didLoad() {
        
    }
    
}
