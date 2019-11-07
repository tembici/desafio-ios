// 
//  DetailOfMoviePresenter.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit
import CoreData

class DetailOfMoviePresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: DetailOfMovieView!
    private var router: DetailOfMovieRouter
    
    //MARK: MANAGER
    var movie: Movie?
    lazy var manager: DetailMovieManager = {
        let m = DetailMovieManager(delegate: self)
        return m
    }()
    
    //MARK: COREDATA
    let coreData = CoreDataManager.sharedManager
  
    //MARK: INIT
    init(view: DetailOfMovieView, router: DetailOfMovieRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: VIEW LIFE CYCLE
    func viewDidLoad() {
        view.configure()
        guard let movie = movie else { return }
        manager.getDetailOfMovie(id: movie.id)
        getMovie(id: movie.id)
    }
    
    //MARK: FAVORITE MOVIE
    func getMovie(id: Int) {
        guard let movieIsFavorited = coreData.getMovie(id: id) else { return }
        
        if movieIsFavorited {
            view.setImage(image: #imageLiteral(resourceName: "favorite_full_icon"))
        } else {
            view.setImage(image: #imageLiteral(resourceName: "favorite_gray_icon"))
        }
    }
    
    func favorite() {
        guard let movie = movie else { return }
        let favorite = coreData.insertMovie(movie: movie)
        
        if favorite != nil {
            view.setImage(image: #imageLiteral(resourceName: "favorite_full_icon"))
        } else {
            view.setImage(image: #imageLiteral(resourceName: "favorite_gray_icon"))
        }
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
                movieOverview: detailOfMovie.overview))
        }
    }
    
    func error(message: String) {
        self.view.error(message: message)
    }
    
}
