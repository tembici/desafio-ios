//
//  ViewController.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var listMoviesManager: ListOfMoviesManager = {
        return ListOfMoviesManager(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listMoviesManager.getPopularMovies(page: 1)
    }

}

extension ViewController: ListOfMoviesManagerDelegate {
    
    func success(listOfMovies: ListOfMovies) {
        print(listOfMovies.results.count)
    }
    
    func error(message: String) {
        print(message)
    }
    
}
