//
//  FavoritesPresenterBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class FavoritesPresenterBuilder{
    
    static func make(wireframe: FavoritesWireframe, interactor: FavoritesInteractor) -> FavoritesPresenter{
        
        let presenter = FavoritesPresenter(wireframe: wireframe, interactor: interactor)
        interactor.output = presenter
        
        return presenter
    }
}
