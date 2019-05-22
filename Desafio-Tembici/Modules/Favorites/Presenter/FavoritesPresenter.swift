//
//  FavoritesPresenter.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

protocol FavoritesPresenterInput{
    
    var output: FavoritesPresenterOutput?{get set}
    
    func viewDidLoad()
}

protocol FavoritesPresenterOutput: class{
    
    func loadUIFavoriteMovies(display: [FavoriteDisplay])
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
    
    func viewDidLoad() {
        
        self.interactor.fetchMovies()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput{
    
    func foundFavoriteMovies(items: [FavoriteItem]) {
        
        self.favoriteItems = items
        
        let favoritesDisplay = FavoriteMapper.make(from: items)
        
        output?.loadUIFavoriteMovies(display: favoritesDisplay)
    }
}
