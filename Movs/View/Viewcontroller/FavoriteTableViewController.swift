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
    
    var moviesList:[Movie]?
    
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
}

extension FavoriteTableViewController // UITableViewDelegate
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteList.shared.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for:indexPath) as! FavoriteTableViewCell
        cell.movie = FavoriteList.shared.list[indexPath.row]
        return cell
    }
}
extension FavoriteTableViewController // UITableViewDataSource
{
    
}


extension FavoriteTableViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
    }
}


