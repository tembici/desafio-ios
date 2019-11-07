// 
//  DetailOfMoviePresenter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class DetailOfMoviePresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: DetailOfMovieView!
    private var router: DetailOfMovieRouter
    
    //MARK: MANAGER
    var id: Int?
    lazy var manager: DetailMovieManager = {
        let m = DetailMovieManager(delegate: self)
        return m
    }()
  
    //MARK: INIT
    init(view: DetailOfMovieView, router: DetailOfMovieRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: VIEW LIFE CYCLE
    func viewDidLoad() {
        guard let id = id else { return }
        manager.getDetailOfMovie(id: id)
    }
    
    //MARK: NAVIGATION
    func prepare(segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(segue: segue, sender: sender)
    }
    
}

//MARK: DetailMovieManagerDelegate
extension DetailOfMoviePresenter: DetailMovieManagerDelegate {
    
    func success(detailOfMovie: DetailOfMovie) {
        ManagerImage.shared.downloadImageFrom(detailOfMovie.posterPath) { (movieImage) in
            self.view.display(detailModel: DetailModel(
                movieName: detailOfMovie.title,
                movieImage: movieImage,
                movieDate: detailOfMovie.releaseDate,
                movieGenre: detailOfMovie.genres,
                movieOverview: detailOfMovie.overview,
                movieIsFavorited: false))
        }
    }
    
    func error(message: String) {
        self.view.error(message: message)
    }
    
}
