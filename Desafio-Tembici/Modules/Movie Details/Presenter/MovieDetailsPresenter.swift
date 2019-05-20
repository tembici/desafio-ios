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
}

protocol MovieDetailsPresenterOutput: class{
    
}

final class MovieDetailsPresenter: MovieDetailsPresenterInput{
    
    weak var output: MovieDetailsPresenterOutput?
}
