//
//  FavoriteTableViewController.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

class FavoriteTableViewController : UITableViewController {
    
    var movieViewModel:MovieViewModel?
    var cellWidthScaling:CGFloat = 0.52
    var cellHeightScaling:CGFloat = 0.91
    var cellSpacing:CGFloat = 16
    
    var filteredMovies = [Movie]()
    var isfiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func performToDatails(with movie:Movie){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as? MovieDetailViewController
        {
            vc.movie = movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FavoriteTableViewController // UITableViewDelegate UITableViewDataSource
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isfiltered
        {
            return self.filteredMovies.count
        }
        return FavoriteList.shared.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for:indexPath) as! FavoriteTableViewCell
        if isfiltered {
            cell.movie = self.filteredMovies[indexPath.row]
        }
        else{
            cell.movie = FavoriteList.shared.list[indexPath.row]
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performToDatails(with: FavoriteList.shared.list[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            if isfiltered {
                FavoriteList.shared.favoriteHandler(with: filteredMovies[indexPath.row])
                filteredMovies.remove(at: indexPath.row)
            }
            else{
                FavoriteList.shared.favoriteHandler(with: FavoriteList.shared.list[indexPath.row])
            }
            tableView.reloadData()
        }
    }
}

extension FavoriteTableViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredMovies.removeAll()
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print(searchText)
        let array = FavoriteList.shared.list.filter {
            return $0.title!.range(of: searchText, options: .caseInsensitive) != nil ||
                $0.overview!.range(of: searchText, options: .caseInsensitive) != nil
        }
        print(array)
        self.filteredMovies = array
        isfiltered = !searchText.isEmpty
        self.tableView.reloadData()
    }
}


