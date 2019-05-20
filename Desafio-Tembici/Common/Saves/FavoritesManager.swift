//
//  FavoritesManager.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class FavoritesManager{
    
    static func isFavorite(_ movieId: Int) -> Bool{
        return UserDefaults.standard.bool(forKey: String(movieId))
    }
    
    static func setFavorite(_ movieId: Int){
        UserDefaults.standard.set(true, forKey: String(movieId))
    }
    
    static func unfavorite(_ movieId: Int){
        UserDefaults.standard.set(false, forKey: String(movieId))
    }
}
