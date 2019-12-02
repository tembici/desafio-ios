//
//  SearchViewController.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    
    public var searchResult: [SearchResult] = [SearchResult]()
    public var searchParameter: String = ""
    public var searchPage: Int = 0
    public var movieId: String?
    
    private var favorites: [NSManagedObject] = []
    private var currentPage: Int = 0
    private var totalPages: Int = 100
    private var expectingEndDecelarationEvent: Bool = false
    private var movie: Movie?
    private var api: MoviesServices = MoviesServices()
    
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if searchParameter != "" {
            loadMoreData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchTableViewCell
        let repository = "https://image.tmdb.org/t/p/w154/"
        let address = URL(string: "\(repository)\(searchResult[indexPath.row].posterPath)")
        let data = try? Data(contentsOf: address!)
        
        if let imageData = data {
            cell.poster?.image = UIImage(data: imageData)
        }
        cell.title?.text = searchResult[indexPath.row].originalTitle
        cell.releaseDate?.text = searchResult[indexPath.row].releaseDate
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        paragraphStyle.alignment = .justified
        
        cell.itemDescription?.attributedText = NSMutableAttributedString(string: searchResult[indexPath.row].overview, attributes: [.font: UIFont.systemFont(ofSize: 16.0, weight: .regular), .foregroundColor: UIColor.white, .kern: 0.0, .paragraphStyle: paragraphStyle])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieId = searchResult[indexPath.row].itemId
        performSegue(withIdentifier: "viewDetailsFromSearch", sender: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let _ = searchBar.text {
            loadMoreData()
        }
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
    
    func loadMoreData() {
        
        if (currentPage + 1) <= totalPages {
            
            currentPage = currentPage + 1
            
            api.search(query: searchBar?.text ?? searchParameter, page: currentPage) { (data, error) in
                
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
                    let item = SearchResult(itemId: String(result.1["id"].int!), releaseDate: result.1["release_date"].string ?? "", originalTitle: result.1["original_title"].string ?? "", posterPath: (result.1["poster_path"].string ?? ""), overview:  (result.1["overview"].string ?? ""))
                    self.searchResult.append(item)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let tvc = segue.destination as? MovieDetailsViewController {
            tvc.movieId = movieId!
        }
    }

}

