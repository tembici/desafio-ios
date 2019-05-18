//
//  MovieMapper.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class MovieMapper{
    
    static func make(from movie: MovieAPIModel) -> MovieEntity?{
        
        guard let id = movie.id,
              let title = movie.title,
              let releaseDate = movie.release_date,
              let sinopse = movie.overview,
              let thumb = movie.poster_path else{
                
                return nil
        }
        return MovieEntity(id: id, title: title, releaseDate: releaseDate, sinopse: sinopse, thumb: thumb)
    }
    
    static func make(from movie: MovieEntity) -> MovieItem?{
        
        guard let id = movie.id,
              let title = movie.title,
              let thumb = movie.thumb else{
                
                return nil
        }
        
        return MovieItem(id: id, title: title, thumb: thumb, favorite: movie.favorite)
    }
    
    static func make(from movie: MovieItem) -> MovieDisplay?{
        
        guard let id = movie.id,
              let title = movie.title,
              let thumb = movie.thumb,
              let favorite = movie.favorite else{
                
                return nil
        }
        
        guard let thumbIcon = UIImage(named: thumb) else{
            
            return nil
        }
        
        return MovieDisplay(id: id, thumb: thumbIcon, title: title, favorite: favorite)
    }
}
