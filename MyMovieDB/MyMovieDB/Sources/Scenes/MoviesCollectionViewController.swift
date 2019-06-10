//
//  MainViewController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 24/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit
import JGProgressHUD

class MoviesCollectionViewController: UICollectionViewController, MovieCollectionViewDelegate {
    
    private let cellIdentifier = "moveisCellIdentifier"
    private var movies: [MovieResult] = []
    private var page: Int = 1
    private let loadingView: JGProgressHUD = JGProgressHUD(style: .light)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestMovies()
    }
    
    private func requestMovies() {
        loadingView.show(in: self.view)
        Manager().requestMovies(param: PopularMovieParam()) { (response, error) in
            if let results = response?.results {
                if results.isEmpty {
                    self.showEmptyView()
                } else {
                    self.movies = results
                    self.page = response?.page ?? 1
                }
            } else if let _error = error {
                self.showEmptyView()
                self.display(errorAlert(error: _error))
                Logger().log(_error.localizedDescription)
            }
            self.collectionView.reloadData()
            self.loadingView.dismiss()
        }
    }
    
    private func requestMoreMovie(page: Int) {
        loadingView.show(in: self.view)
        Manager().requestMovies(param: PopularMovieParam(page: page)) { (response, error) in
            if let results = response?.results {
                self.movies += results
                self.page = response?.page ?? 1
                self.collectionView.reloadData()
            } else if let _error = error {
                self.display(errorAlert(error: _error))
                Logger().log(_error.localizedDescription)
            }
            self.loadingView.dismiss()
        }
    }

    private func configureUI() {
        title = NSLocalizedString("MOVIES_TITLE", comment: "")
    }
    
    private func display(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showEmptyView() {
        let emptyView = EmptyView()
        emptyView.configure(menssage: Utils.getLocalizedString("NO_MOVIES"))
        emptyView.center = collectionView.center
        collectionView.addSubview(emptyView)
    }
    
    func handlerActionFavorite(movie: MovieResult) {
        var _movie = movie
        _movie.favorite = !_movie.favorite
        do {
            try CoreDataController().saveOrUpdate(movie: _movie)
        } catch {
            Logger().log(error.localizedDescription)
        }
    }
    
    private func navigateToDetailController(using movie: MovieResult) {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        guard let movieDetailController = storyboard.instantiateInitialViewController() as? MovieDetailController else { return }
        movieDetailController.movie = movie
        
        show(movieDetailController, sender: nil)
    }
}

extension MoviesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movies.count > 0 ? 1 : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        collectionViewCell.cellDelegate = self
        
        do {
            if let favoriteMovies = try CoreDataHelper().getData(in: Entitys.Movie) {
                for favorited in favoriteMovies {
                    if self.movies[indexPath.row].id == favorited.value(forKey: "id") as! Int {
                        self.movies[indexPath.row].favorite = (favorited.value(forKey: "favorite") as! Bool)
                    }
                }
            }
        } catch {
            // ...
        }
        collectionViewCell.displayUI(movies[indexPath.row])
        
        return collectionViewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailController(using: movies[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            requestMoreMovie(page: page + 1)
        }
    }
}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let internalSpacing: CGFloat = 16
        let externalSpacing: CGFloat = 16 * 2 // (left and right spacing)
        let width: CGFloat = (collectionView.frame.width - internalSpacing - externalSpacing ) / 2
        let height: CGFloat = 230.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

