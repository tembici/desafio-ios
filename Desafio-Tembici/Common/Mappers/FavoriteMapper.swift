//
//  FavoriteMapper.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class FavoriteMapper{
    
    static func make(from movies: [MovieEntity]) -> [FavoriteItem]{
        
        var favorites: [FavoriteItem] = []
        
        for movie in movies{
            
            if movie.favorite{
                
                guard let year = movie.releaseDate?.prefix(4) else{
                    return []
                }
                guard let title = movie.title,
                    let sinopse = movie.sinopse,
                    let thumb = movie.thumb else{
                        return []
                }
                
               let vpurl = VPURL(urlString: "https://image.tmdb.org/t/p/w1280/"+thumb)
                var data: Data?
                
                do{
                    let url = try vpurl.asURL()
                    data = NSData(contentsOf: url) as Data?
                }catch{
                    print("deu ruim")
                }
                
                let favorite = FavoriteItem(title: title, sinopse: sinopse, year: String(year), thumb: data!)
                
                favorites.append(favorite)
            }
        }
        return favorites
    }
    
    static func make(from movies: [FavoriteItem]) -> [FavoriteDisplay]{
        
        var favoritesDisplay: [FavoriteDisplay] = []
        
        for movie in movies{
            
            guard let thumb = UIImage(data: movie.thumb) else{
                return []
            }
            
            let favorite = FavoriteDisplay(title: movie.title, sinopse: movie.sinopse, year: movie.year, thumb: thumb)
            favoritesDisplay.append(favorite)
        }
        return favoritesDisplay
    }
}
