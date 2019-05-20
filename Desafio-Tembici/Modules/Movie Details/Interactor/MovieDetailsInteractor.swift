//
//  MovieDetailsInteractor.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol MovieDetailsInteractorInput{
    
    var output: MovieDetailsInteractorOutput?{ get set}
}

protocol MovieDetailsInteractorOutput: class {
    
}

final class MovieDetailsInteractor: MovieDetailsPresenterInput{
    
    weak var output: MovieDetailsPresenterOutput?
}
