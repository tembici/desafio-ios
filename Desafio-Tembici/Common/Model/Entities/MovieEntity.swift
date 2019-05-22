//
//  MovieEntity.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MovieEntity: NSObject{
    
    var id: Int?
    var title: String?
    var releaseDate: String?
    var sinopse: String?
    var thumb: String?
    var favorite: Bool{
        
        guard let id = self.id else{
            return false
        }
        return FavoritesManager.isFavorite(id)
    }
    
    init(id: Int, title: String, releaseDate: String, sinopse: String, thumb: String){
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.sinopse = sinopse
        self.thumb = thumb
    }
    
    static func getMovie(in movies: [MovieEntity], byId id: Int) -> MovieEntity?{
        
        guard let index = movies.firstIndex(where: {$0.id == id}) else{ return nil}
        
        return movies[index]
    }
}
