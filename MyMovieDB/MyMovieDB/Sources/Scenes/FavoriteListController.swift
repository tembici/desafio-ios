//
//  FavoriteListController.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 08/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit
import CoreData

class FavoriteListController: UITableViewController {

    private let cellIdentifier = "favoriteCellIdentifier"
    private var favoriteMovies: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Utils.getLocalizedString("FAVORITES_NAVIGATION_TITLE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            self.favoriteMovies = try CoreDataHelper().getData(in: Entitys.Movie) ?? []
            self.tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func navigateToDetailController(using movie: MovieResult) {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        guard let movieDetailController = storyboard.instantiateInitialViewController() as? MovieDetailController else { return }
        movieDetailController.movie = movie
        
        show(movieDetailController, sender: nil)
    }
}

extension FavoriteListController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return favoriteMovies.count > 0 ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteTableViewCell
        let movie = favoriteMovies[indexPath.row]
        let movieResult = MovieResult().toMovieObject(object: movie)
        cell.configure(movieResult)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = favoriteMovies[indexPath.row]
        let movieResult = MovieResult().toMovieObject(object: movie)
        navigateToDetailController(using: movieResult)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = favoriteMovies[indexPath.row]
            do {
                if try CoreDataHelper().deleteData(object: movie, in: Entitys.Movie) {
                    favoriteMovies.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
