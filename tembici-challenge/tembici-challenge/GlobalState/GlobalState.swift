//
//  GlobalState.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var genres = [Genre]()
    @Published var favorites = [Movie]()
    let realm = RealmManager()
    var isLoading = false
    
    init() {
        self.fetchFavorites()
    }
    
    func addFavorite(movie:Movie){
        
        if let index = favorites.firstIndex(of:movie) {
            favorites.remove(at: index)
            realm.deleteData(favorite: Favorite(movie: movie))
        }else{
            favorites.append(movie)
            realm.saveObject(obj: Favorite(movie: movie))

        }
    }
    
    func fetchFavorites(){
        if let objects = realm.getObjects(type: Favorite.self) {
            for favorite in objects {
               let movie = Movie(movie: favorite)
                favorites.append(movie)
            }
        }
    }
    
    
    
}
