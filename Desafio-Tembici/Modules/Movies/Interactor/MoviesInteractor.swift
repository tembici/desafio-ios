//
//  MoviesInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MoviesInteractorInput{
    
    var output: MoviesInteractorOutput?{ get set}
}

protocol MoviesInteractorOutput: class{
    
}

final class MoviesInteractor: MoviesPresenterInput{
    
    var output: MoviesPresenterOutput?
}
