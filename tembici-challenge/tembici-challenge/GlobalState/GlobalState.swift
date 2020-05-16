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

    var isLoading = false

    func removeFavorite(movie: Movie){
          if let index = favorites.firstIndex(of:movie) {
                    favorites.remove(at: index)
                }else{
                    favorites.append(movie)
                }
       }
       
   func addFavorite(movie:Movie){
       
       if let index = favorites.firstIndex(of:movie) {
           favorites.remove(at: index)
       }else{
           favorites.append(movie)
       }
   }
    
  
}
