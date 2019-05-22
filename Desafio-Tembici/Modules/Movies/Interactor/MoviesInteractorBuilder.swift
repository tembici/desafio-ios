//
//  MoviesInteractorBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MoviesInteractorBuilder{
    
    static func make() -> MoviesInteractor{
        
        let manager = MoviesManager()
        let interactor = MoviesInteractor()
        
        interactor.manager = manager
        
        return interactor
    }
}
