//
//  MoviesWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MoviesWireframe{
    
    func getViewController() -> MoviesViewController{
        
        return MoviesViewControllerBuilder.make(wireframe: self)
    }
    
    func presentDetails(for movie: MovieEntity){
        
        MovieDetailsWireframe().present(movie: movie)
    }
}
          
