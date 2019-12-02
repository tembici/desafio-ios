//
//  DiscoverViewController.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reusableCellIdentifier: String = "MovieCardCell"

class DiscoverViewController: LoggingViewController, UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout , UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var api: MoviesServices = MoviesServices()
    private var discoverResult: [DiscoverResult] = [DiscoverResult]()
    private var cellHeight: CGFloat = (UIScreen.main.bounds.height / 3) * 0.9
    private var cellWidth: CGFloat = (UIScreen.main.bounds.width / 3) * 0.9
    private var currentPage: Int = 0
    private var totalPages: Int = 100
    private var movieId: String?
    private var expectingEndDecelarationEvent: Bool = false
    private var refreshControl: UIRefreshControl!
    private var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        movieCollection.register(UINib(nibName: "MovieCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reusableCellIdentifier)
        
        searchBar.delegate = self
        movieCollection.delegate = self
        
        movieCollection.keyboardDismissMode = .onDrag
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Arraste para atualizar")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.touchDragExit)
        movieCollection.addSubview(refreshControl)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieCollection.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        loadMoreData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSearchResult" {
            let tvc = segue.destination as! SearchViewController
            tvc.searchPage = 1
            tvc.searchParameter = searchBar.text!
        } else {
            let tvc = segue.destination as! MovieDetailsViewController
            tvc.movieId = movieId!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return discoverResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellIdentifier, for: indexPath) as! MovieCardCollectionViewCell
        
        cell.setVote(String(discoverResult[indexPath.row].voteCount))
        cell.setMoviePoster(discoverResult[indexPath.row].posterPath)
        cell.setMovieScore(discoverResult[indexPath.row].voteAverage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        movieId = discoverResult[indexPath.row].id
        performSegue(withIdentifier: "viewDetailsFromDiscover", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (collectionView.numberOfItems(inSection: 0) - 1) {
            loadMoreData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "viewSearchResult", sender: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard decelerate == false else {
            expectingEndDecelarationEvent = true
            return
        }
        expectingEndDecelarationEvent = false
        loadMoreData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard expectingEndDecelarationEvent else { return }
        expectingEndDecelarationEvent = false
        loadMoreData()
    }
    
    private func loadMoreData() {
        
        if (currentPage + 1) <= totalPages {
            
            currentPage = currentPage + 1
            
            api.popular(page: currentPage) { (data, error) in
                
                self.activityIndicator.stopAnimating()
                
                guard error == nil else {
                    self.showAlert("Não foi possível realizar essa busca.")
                    return
                }
                
                guard (data?.lengthOfBytes(using: .utf8))! > 0 else {
                    return
                }
                
                let jsonResult = JSON.init(parseJSON: data!)
                
                self.totalPages = jsonResult["total_pages"].int ?? 0
                
                for result in jsonResult["results"] {
                    if let item = try? DiscoverResult.init(
                        voteCount: result.1["vote_count"].int ?? 0,
                        voteAverage: result.1["vote_average"].float ?? 0.0,
                        originalLanguage: result.1["original_language"].string ?? "",
                        releaseDate: result.1["release_date"].string ?? "",
                        backdropPath: result.1["backdrop_path"].string ?? "",
                        genreIDS: result.1["genre_ids"].arrayObject as? [Int] ?? [],
                        posterPath: result.1["poster_path"].string ?? "",
                        video: result.1["video"].bool ?? false,
                        title: result.1["title"].string ?? "",
                        adult: result.1["adult"].bool ?? false,
                        overview: result.1["overview"].string ?? "",
                        id: String(result.1["id"].int ?? 0),
                        originalTitle: result.1["original_title"].string ?? "",
                        popularity: result.1["popularity"].double ?? 0.0)
                    {
                        
                        self.discoverResult.append(item)
                    }
                }
                
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                    self.movieCollection.reloadData()
                }
            }
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    
    @objc func refresh(_ sender : AnyObject) {
        api.popular(page: 1) {_,_ in
            
        }
    }
    
    
}
