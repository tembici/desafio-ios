//
//  MovieListViewController.swift
//  Movs
//
//  Created by Ivan Ortiz on 15/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

class MovieListViewController : UIViewController {
    
    var movieViewModel:MovieViewModel?
    var cellWidthScaling:CGFloat = 0.52
    var cellHeightScaling:CGFloat = 0.91
    var cellSpacing:CGFloat = 16
    
    var moviesList:[Movie]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search

        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movCell")

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellWidthScaling) - (cellSpacing * 2)
        let cellHeight = floor(screenSize.width * cellHeightScaling) - (cellSpacing * 2)
        
        layout.itemSize = CGSize(width:cellWidth,height:cellHeight)
        
        collectionView.contentInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        collectionView.dataSource = self
        collectionView.delegate = self

        movieViewModel = MovieViewModel()
        movieViewModel?.delegate = self
        movieViewModel?.getMoviesList()
    }
}

extension MovieListViewController : MovieViewModelDelegate
{
    func didGetGenreList(genres: [Genre]?, error: Bool, errorType: String?) {
    }
    func didGetMoviesList(movies: [Movie]?, error: Bool, errorType: String?) {
        
        if !error
        {
            moviesList = movies
            collectionView.reloadData()
        }
        movieViewModel?.getGenreList()
    }
}
extension MovieListViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MovieListViewController:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movCell", for: indexPath) as! MovieCollectionViewCell
        cell.delegate = self
        cell.movie = moviesList?[indexPath.row]
        return cell
    }
}
extension MovieListViewController : MovieCollectionViewCellDelegate
{
    func favoritePressed(with movie: Movie?) {
        FavoriteList.shared.favoriteHandler(with: movie!)
    }
}
extension MovieListViewController:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

