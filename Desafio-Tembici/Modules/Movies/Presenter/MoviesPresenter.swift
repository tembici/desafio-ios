//
//  MoviesPresenter.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MoviesPresenterInput{
    
    var output: MoviesPresenterOutput?{ get set}
}

protocol MoviesPresenterOutput: class{
    
}

final class MoviesPresenter: MoviesPresenterInput{
    
    var output: MoviesPresenterOutput?
}
