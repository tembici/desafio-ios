//
//  FavoriteMoviesViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 28/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {

    @IBOutlet var stateView: StateFullView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies:[MovieViewModel] = [] {
        didSet {
            if (movies.count == 0) {
                stateView.setState(.empty("There are no favorite movies in your list", image: nil))
            } else {
                stateView.setState(.normalLayout)
            }
            moviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovies()
    }
    
    private func setupTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        moviesTableView.register(UINib(nibName: "FavoriteMovieTableViewCell", bundle: nil), forCellReuseIdentifier: CellReuse.MOVIE_FAVORITE_CELL)
    }
    
    private func getMovies() {
        let coreDataManager = CoreDataManager()
        stateView.setState(.loading("Loading favorite movies..."))
        stateView.setErrorCompletion { self.getMovies() }
        coreDataManager.fetch(MovieData.self, successCompletion: { (moviesData) in
            self.movies = self.getMoviesViewModel(moviesData)
        }) { (error) in
            self.stateView.setState(.error("Could't load favorite movies."))
        }
    }
    
    private func getMoviesViewModel(_ moviesData:[MovieData]) -> [MovieViewModel] {
        var returnMovies:[MovieViewModel] = []
        for movieData in moviesData {
            returnMovies.append(bindToMovieViewModel(movieData))
        }
        return returnMovies
    }
    
    private func bindToMovieViewModel(_ movieData:MovieData) -> MovieViewModel {
        
        return MovieViewModel(_id: movieData.id,
                              _averageRating: movieData.averageRating,
                              _genresIds: movieData.genres as! [Int],
                              _originalTitle: movieData.originalTitle ?? "",
                              _backdropPath: movieData.backdropPath ?? "",
                              _isAdult: movieData.isAdult,
                              _popularity: movieData.popularity,
                              _posterPath: movieData.posterPath ?? "",
                              _title: movieData.title ?? "",
                              _overview: movieData.overview ?? "",
                              _originalLanguage: movieData.originalLanguage ?? "",
                              _voteCount: movieData.voteCount,
                              _releaseDate: movieData.releaseDate ?? Date(),
                              _isVideo: movieData.isVideo)
    }
}


extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuse.MOVIE_FAVORITE_CELL) as! FavoriteMovieTableViewCell
        if (movies.indices.contains(indexPath.row)) {
            cell.setMovieInfo(movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
