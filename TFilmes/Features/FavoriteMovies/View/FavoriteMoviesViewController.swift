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
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var emptyStateLabel: UILabel!

    private let segueToFilterIdentifier = "segueToFilter"
    private let segueToMovieDetailIdentifier = "segueToMovieDetail"

    private lazy var presenter: FavoriteMoviesPresenterToView = {
        return FavoriteMoviesPresenter(view: self)
    }()

    private var movies: [Movie] = []
    private var rowTapped: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewDidAppear()

        let nib = UINib(nibName: FavoriteMovieTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: FavoriteMovieTableViewCell.identifier)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.removeFilterButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case self.segueToFilterIdentifier: self.prepareFilterFavorite(segue.destination)
        case self.segueToMovieDetailIdentifier: self.prepareDetail(segue.destination)
        default: return
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

    private func removeFilterButton() {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    private func prepareFilterFavorite(_ destination: UIViewController) {
        guard let view = destination as? FilterFavoriteMoviesViewController else { return }
        view.delegate = self
        view.genreIdsFilter = self.presenter.genreIdsFilter
        view.yearsFilter = self.presenter.yearsFilter
    }

   private func prepareDetail(_ destination: UIViewController) {
        guard let row = self.rowTapped, row < self.movies.count else { return }
        guard let view = destination as? MovieDetailViewController else { return }
        view.movieToShow = self.movies[row]
   }

    private func checkEmptyState() {
        self.emptyStateView.isHidden = !self.movies.isEmpty

        if self.movies.isEmpty {
            self.removeFilterButton()
            self.checkEmptyStateFilters()
        } else {
            self.showFilterButton()
        }
    }

    private func checkEmptyStateFilters() {
        var message = NSLocalizedString("favorites.empty.default", comment: "Default message")

        defer {
            self.emptyStateLabel.text = message
        }

        let hasFilter = !self.presenter.genreIdsFilter.isEmpty || !self.presenter.yearsFilter.isEmpty

        if hasFilter {
            message = NSLocalizedString("favorites.empty.only_filter", comment: "Filter message")
        }

        guard let searchQuery = self.searchBar.text, !searchQuery.isEmpty else { return }

        var keyMessage = "favorites.empty.only_query"

        if hasFilter {
            keyMessage = "favorites.empty.query_with_filters"
        }

        message = NSLocalizedString(keyMessage, comment: "Query message")
        message = message.replacingOccurrences(of: "#text#", with: searchQuery)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowTapped = indexPath.row
        self.performSegue(withIdentifier: self.segueToMovieDetailIdentifier, sender: self)
    }

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

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            self.presenter.deleteFavoriteTrigger(self.movies[indexPath.row])
            self.movies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.checkEmptyState()
        }
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

        if !movies.isEmpty {
            self.tableView.reloadData()
        }

        self.checkEmptyState()
    }

}

// MARK: - FavoriteMoviesViewController

extension FavoriteMoviesViewController: FilterFavoriteMoviesDelegate {

    func applyFiltersTapped(years: [Int], genreIds: [Int]) {
        self.presenter.filterUpdated(years: years, genreIds: genreIds)
    }

}
