//
//  FavoritesInteractorBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class FavoritesInteractorBuilder{
    
    static func make() -> FavoritesInteractor{
        
        let manager = MoviesManager()
        
        return FavoritesInteractor(manager: manager)
    }
}
