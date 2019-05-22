//
//  MoviesManager.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MoviesManager{
    
    var api = MoviesAPI()

    func getMovies(completion: @escaping ([MovieEntity])->()){
        
        api.getMovies { (movies) in
            
            var moviesArray: [MovieEntity] = []
            
            for movie in movies{
                
                guard let movie = MovieMapper.make(from: movie) else{
                    return
                }
                moviesArray.append(movie)
            }
            completion(moviesArray)
        }
    }
}
