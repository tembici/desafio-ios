//
//  FavoritesPresenter.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol FavoritesPresenterInput{
    
    weak var output: FavoritesPresenterOutput?{get set}
}

protocol FavoritesPresenterOutput: class{
    
}

final class FavoritesPresenter: FavoritesPresenterInput{
    
    weak var output: FavoritesPresenterOutput?
    var interactor: FavoritesInteractor
    var wireframe: FavoritesWireframe
    
    var favoriteItems: [FavoriteItem] = []
    
    init(wireframe: FavoritesWireframe, interactor: FavoritesInteractor){
        
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput{
    
}
