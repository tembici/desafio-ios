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
    var filtered: [Movie] = []
    var isFiltered: Bool = false
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
        view.configureUI()
        view.removeBlackSpace()
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
    
    //MARK: FILTERED
    func filtered(_ searchText: String, scope: String = "All") {
        if searchText != "" {
            isFiltered = true
            filtered = movies.filter { item in
                return (item.title.lowercased().contains(searchText.lowercased()))
            }
        } else {
            isFiltered = false
            filtered = movies
        }
        
        if filtered.count == 0 {
            view.error(message: "We didn't find any \nmovies with this name")
            view.collectionIsHidden()
        } else {
            view.error(message: "")
            view.collectionNotHidden()
        }
        
        view.reloadData()
    }

    
    //MARK: CELL
    func configure(_ cell: ListCell, index: Int) {
        var m: Movie?
        
        if isFiltered {
            m = filtered[index]
        } else {
            m = movies[index]
        }
        
        guard let movie = m else { return }
        ManagerImage.shared.downloadImageFrom(movie.posterPath) { (movieImage) in
            cell.movieModel = MovieModel(movieName: movie.title,
                                         movieImage: movieImage,
                                         movieIsFavorited: false)
        }
    }
    
    //MARK: DID SELECT
    func didSelect(index: Int) {
        if isFiltered {
            router.presentDetail(id: filtered[index].id)
        } else {
            router.presentDetail(id: movies[index].id)
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
        self.view.error(message: message)
    }
    
}
