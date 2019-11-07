// 
//  ListOfMoviesRouter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListOfMoviesRouter {
    
    //MARK: PROPERTIES
    private var controller: ListOfMoviesController?
  
    //MARK: INIT
    init(_ controller: ListOfMoviesController) {
        self.controller = controller
    }
    
    //MARK: SEGUE
    private let detail = "detail"
    
    //MARK: PRESENT
    func presentDetail(movie: Movie) {
        controller?.performSegue(withIdentifier: detail, sender: movie)
    }
    
    //MARK: NAVIGATION
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detail {
            if let vc = segue.destination as? DetailOfMovieController {
                vc.presenter.movie = sender as? Movie
            }
        }
    }
    
}
