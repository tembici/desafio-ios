// 
//  DetailOfMovieRouter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class DetailOfMovieRouter {
    
    //MARK: PROPERTIES
    private var controller: DetailOfMovieController?
  
    //MARK: INIT
    init(_ controller: DetailOfMovieController) {
        self.controller = controller
    }
    
    //MARK: SEGUE
    
    //MARK: PRESENT
    
    //MARK: NAVIGATION
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
