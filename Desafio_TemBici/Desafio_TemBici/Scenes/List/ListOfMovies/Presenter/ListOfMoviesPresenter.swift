// 
//  ListOfMoviesPresenter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ListOfMoviesPresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: ListOfMoviesView!
    private var router: ListOfMoviesRouter
    
    //MARK: MANAGER
    var movies: [Movie] = []
    private var page: Int = 0
    private var totalPages: Int = 0
    lazy var manager: ListOfMoviesManager = {
        let m = ListOfMoviesManager(delegate: self)
        return m
    }()
  
    //MARK: INIT
    init(view: ListOfMoviesView, router: ListOfMoviesRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: VIEW LIFE CYCLE
    func viewDidLoad() {
        view.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.manager.getPopularMovies(page: 1)
        }
    }
    
    //MARK: NETWORK
    private func getMovies(page: Int) {
        manager.getPopularMovies(page: page)
    }
    
    //MARK: PAGINATION
    func getMoreMovies(for row: Int) {
        if page != totalPages {
            if row == movies.count - 10 {
                if page != totalPages {
                    getMovies(page: page + 1)
                    page += 1
                }
            }
        }
    }
    
    //MARK: CELL
    func configure(_ cell: ListCell, index: Int) {
        let movie = movies[index]
        
        manager.downloadImageFrom(movie.posterPath) { (movieImage) in
            cell.movieModel = MovieModel(movieName: movie.title,
                                         movieImage: movieImage,
                                         movieIsFavorited: false)
        }
    }
        
    //MARK: NAVIGATION
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(segue: segue, sender: sender)
    }
    
}

//MARK: ListOfMoviesManagerDelegate
extension ListOfMoviesPresenter: ListOfMoviesManagerDelegate {
    
    func success(listOfMovies: ListOfMovies) {
        self.view.stopLoading()
        self.page = listOfMovies.page
        self.totalPages = listOfMovies.totalPages
        self.movies += listOfMovies.results
        self.view.reloadData()
    }
    
    func error(message: String) {
        print(message)
    }
    
}
