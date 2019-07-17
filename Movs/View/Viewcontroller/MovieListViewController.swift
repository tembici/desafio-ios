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
    
    var segueIdentifier = "movieDatails"
    var selectedMovie:Movie?
    var moviesList = [Movie]()
    var filteredMovies = [Movie]()
    var isfiltered = false
    var page = 1
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var acvLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    func setupViews()
    {
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
        loadMoreMovies()
        movieViewModel?.getGenreList()
    }
    func loadMoreMovies()
    {
        movieViewModel?.getMoviesList(page:page)
    }
    func performeToDetail(with movie:Movie)
    {
        self.selectedMovie = movie
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier
        {
            if let vc = segue.destination as? MovieDetailViewController
            {
                vc.movie = selectedMovie
                selectedMovie = nil
            }
        }
    }
}

extension MovieListViewController : MovieViewModelDelegate
{
    func didGetGenreList(genres: [Genre]?, error: Bool, errorType: String?) {
        if !error && genres != nil
        {
            GenresList.shared.list = genres!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didGetGenreList"), object: nil, userInfo: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Oops", message: "Unable to load the information about genres.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    func didGetMoviesList(movies: [Movie]?, error: Bool, errorType: String?) {
        acvLoading.stopAnimating()
        if !error && movies != nil
        {
            page = page + 1
            moviesList.append(contentsOf: movies!)
            collectionView.reloadData()
        }
        else
        {
            let view = UINib(nibName: "GenericErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
            collectionView.backgroundView = view
        }
    }
}
extension MovieListViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {

        self.filteredMovies.removeAll()
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print(searchText)
        let array = moviesList.filter {
            return $0.title!.range(of: searchText, options: .caseInsensitive) != nil ||
                $0.overview!.range(of: searchText, options: .caseInsensitive) != nil
        }
        print(array)

        self.filteredMovies = array
        if self.filteredMovies.count < 1 && !searchText.isEmpty
        {
            let view = UINib(nibName: "EmptySearchView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptySearchView
            view.searchText = searchText
            collectionView.backgroundView = view
        }

        isfiltered = !searchText.isEmpty
        self.collectionView.reloadData()
    }
}

extension MovieListViewController:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isfiltered
        {
            if self.filteredMovies.count > 0
            {
                collectionView.backgroundView = nil
            }
            return self.filteredMovies.count
        }
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movCell", for: indexPath) as! MovieCollectionViewCell
        cell.delegate = self
        if isfiltered {
            cell.movie = self.filteredMovies[indexPath.row]
        }
        else{
            cell.movie = moviesList[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isfiltered && (indexPath.row == moviesList.count-1) {
            loadMoreMovies()
        }
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
        performeToDetail(with:moviesList[indexPath.row])
    }
}

