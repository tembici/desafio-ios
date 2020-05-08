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

    private let segueToFilterIdentifier = "segueToFilter"

    private lazy var presenter: FavoriteMoviesPresenterToView = {
        return FavoriteMoviesPresenter(view: self)
    }()

    private var movies: [Movie] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewDidAppear()

        let nib = UINib(nibName: FavoriteMovieTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: FavoriteMovieTableViewCell.identifier)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? FilterFavoriteMoviesViewController {
            viewController.delegate = self
            viewController.genreIdsFilter = self.presenter.genreIdsFilter
            viewController.yearsFilter = self.presenter.yearsFilter
        }
    }

}

// MARK: - Actions

extension FavoriteMoviesViewController {

    @objc func filterTapped() {
        self.performSegue(withIdentifier: self.segueToFilterIdentifier, sender: self)
    }

}



// MARK: - Private methods

extension FavoriteMoviesViewController {

    private func showFilterButton() {
        let barButton = UIBarButtonItem(
            image: UIImage(named: "funnel_icon"),
            style: .plain,
            target: self,
            action: #selector(filterTapped)
        )

        self.tabBarController?.navigationItem.rightBarButtonItem = barButton
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteMovieTableViewCell.identifier,
            for: indexPath
        ) as! FavoriteMovieTableViewCell

        cell.updateCell(with: self.movies[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}

// MARK: - UISearchBarDelegate

extension FavoriteMoviesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterMovies(with: searchBar.text)
    }

}

// MARK: - FavoriteMoviesViewToPresenter

extension FavoriteMoviesViewController: FavoriteMoviesViewToPresenter {

    func updateMovies(with movies: [Movie]) {
        self.movies = movies

        if self.movies.isEmpty {
            // Show empty state
        } else {
            self.showFilterButton()
            self.tableView.reloadData()
        }
    }

}

// MARK: - FavoriteMoviesViewController

extension FavoriteMoviesViewController: FilterFavoriteMoviesDelegate {

    func applyFiltersTapped(years: [Int], genreIds: [Int]) {
        self.presenter.filterUpdated(years: years, genreIds: genreIds)
    }

}
