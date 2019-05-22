//
//  MoviesWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class MoviesWireframe{
    
    var viewController: MoviesViewController?
    
    func getViewController() -> MoviesViewController{
        
        let viewController = MoviesViewControllerBuilder.make(wireframe: self)
        self.viewController = viewController
        
        return viewController
    }
    
    func presentDetails(for movie: MovieEntity){
        
        guard let navigationController = self.viewController?.tabBarController?.navigationController else{
            return
        }
        
        MovieDetailsWireframe().present(navigationController: navigationController, movie: movie)
    }
}
          
