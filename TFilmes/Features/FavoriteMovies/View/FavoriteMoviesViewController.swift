//
//  FavoriteMoviesViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class FavoriteMoviesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private lazy var presenter: FavoriteMoviesPresenterToView = {
        return FavoriteMoviesPresenter(view: self)
    }()

    private var movies: [Movie] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewDidLoad()

        let nib = UINib(nibName: "FavoriteMovieTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "FavoriteMovieTableViewCell")
    }

}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieTableViewCell", for: indexPath) as! FavoriteMovieTableViewCell

        cell.updateCell(with: self.movies[indexPath.row])

        return cell
    }

}

extension FavoriteMoviesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.presenter.filterMovies(with: searchBar.text)
    }

}

// MARK: - FavoriteMoviesViewToPresenter

extension FavoriteMoviesViewController: FavoriteMoviesViewToPresenter {

    func updateMovies(with movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }

}
