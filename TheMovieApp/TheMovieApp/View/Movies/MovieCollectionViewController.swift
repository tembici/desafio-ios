//
//  MovieCollectionViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 24/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit
import CoreData

class MovieCollectionViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet var stateView: StateFullView!
    
    let collectionInsets:CGFloat = 8
    var movies:[MovieViewModel] = [] {
        didSet {
            if (movies.count == 0) {
                stateView.setState(.empty("Não há filmes em destaque no momento. Tente novamente mais tarde", image: nil))
            } else {
                moviesCollectionView.reloadData()
                stateView.setState(.normalLayout)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        getMovies()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellReuse.MOVIE_CELL)
    }
    
    private func getMovies() {
        stateView.setErrorCompletion { self.getMovies() }
        let appProvider = AppProvider()
        stateView.setState(.loading("Carregando filmes populares..."))
        appProvider.makeRequest(.getPopularMovies, returnClass: GeneralMovieResponseModel.self, successCompletion: { (response) in
            self.movies = self.movies + response.getMoviesModel()
            self.stateView.setState(.normalLayout)
        }) { (error) in
            self.stateView.setState(.error(error.localizedDescription))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.SHOW_MOVIE_DETAIL {
            guard let destination = segue.destination as? MovieDetailViewController, let movie = sender as? MovieViewModel else {
                return
            }
            destination.movie = movie
        }
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.SHOW_MOVIE_DETAIL, sender: movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuse.MOVIE_CELL, for: indexPath) as! MovieListCollectionViewCell
        let thisMovie = movies[indexPath.row]
        cell.setMovieCell(thisMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - (2 * collectionInsets)) / 2
        let cellHeight = cellWidth * 1.75
        return CGSize(width: cellWidth, height: cellHeight);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionInsets, left: collectionInsets, bottom: collectionInsets, right: collectionInsets);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MovieCollectionViewController: UISearchControllerDelegate {
    
}
