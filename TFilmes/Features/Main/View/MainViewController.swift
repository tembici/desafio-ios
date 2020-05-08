//
//  MainViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var skeletonCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tryGetMoviesAgainButton: UIButton!
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!

    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    private var movies: [Movie] = []
    private var rowTapped: Int?

    private let dumyIdentifier = "DumyCell"
    private let segueToMovieDetailIdentifier = "segueToMovieDetail"

    override func viewDidLoad() {
        self.skeletonCollectionView.showAnimatedGradientSkeleton()

        let nib = UINib(nibName: MovieCollectionViewCell.nibName, bundle: nil)
        self.collectionView.register(
            nib,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )

        self.presenter.viewDidAppear()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case self.segueToMovieDetailIdentifier: self.prepareDetail(segue.destination)
        default: break
        }
    }

}

// MARK: - Actions

extension MainViewController {

    @IBAction func tryGetMoviesAgainTapped(_ sender: Any) {
        self.tryGetMoviesAgainButton.isHidden = true
        self.presenter.tryToGetMoviesTapped()
    }

}

// MARK: - Private methods

extension MainViewController {

    private func checkEmptyState() {
        self.emptyStateView.isHidden = !self.movies.isEmpty

        guard !self.movies.isEmpty else { return }

        var message = NSLocalizedString("main.empty.default", comment: "Default empty")

        defer {
            self.emptyStateLabel.text = message
        }

        guard let searchQuery = self.searchBar.text, !searchQuery.isEmpty else { return }

        message = NSLocalizedString("main.empty.search", comment: "Search base string")
        message = message.replacingOccurrences(of: "#text#", with: searchQuery)
    }

    private func prepareDetail(_ destination: UIViewController) {
        guard let row = self.rowTapped, row < self.movies.count else { return }
        guard let view = destination as? MovieDetailViewController else { return }
        view.movieToShow = self.movies[row]
        view.delegate = self
    }

}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterMovies(with: searchBar.text)
    }

}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowTapped = indexPath.row
        self.performSegue(withIdentifier: self.segueToMovieDetailIdentifier, sender: self)
    }

}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.collectionView ? self.movies.count : 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.skeletonCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.dumyIdentifier,
                for: indexPath
            )
            cell.showAnimatedGradientSkeleton()
            return cell
        }

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as! MovieCollectionViewCell

        cell.updateData(with: self.movies[indexPath.row])
        cell.delegate = self

        if indexPath.row == self.movies.count - 1 {
            self.loadMoreIndicator.startAnimating()
            self.presenter.fetchMoreMovies()
        }

        return cell
    }

}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

    func updateMovies(with movies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            self?.loadMoreIndicator.stopAnimating()
            self?.skeletonCollectionView.hideSkeleton()
            self?.skeletonCollectionView.isHidden = true
        }

        self.movies.append(contentsOf: movies)

        if !movies.isEmpty {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }

        DispatchQueue.main.async { [weak self] in
            self?.checkEmptyState()
        }

    }

    func removeMovies() {
        self.movies = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func showErrorState() {
        let title = NSLocalizedString("main.error.title", comment: "Error title")
        let message = NSLocalizedString("main.error.message", comment: "Error message")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let tryAgainTitle = NSLocalizedString("main.error.try_again", comment: "Error try again button")
        let tryAgainAction = UIAlertAction(title: tryAgainTitle, style: .default) { _ in
            self.presenter.tryToGetMoviesTapped()
        }

        alert.addAction(tryAgainAction)

        let cancelTitle = NSLocalizedString("main.error.cancel", comment: "Error cancel button")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            self.tryGetMoviesAgainButton.isHidden = false
        }

        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

}

// MARK: - MovieColletionViewCellDelegate

extension MainViewController: MovieColletionViewCellDelegate {

    func favoriteButtonTapped(movie: Movie) {
        if let currentMovieIndex = self.movies.firstIndex(where: { $0.id == movie.id }) {
            self.movies[currentMovieIndex].favorite = movie.favorite
        }

        self.presenter.favoriteChanged(movie: movie)
    }

}

// MARK: - MovieDetailDelegate

extension MainViewController: MovieDetailDelegate {

    func favoriteChanged(movie: Movie) {
        if let currentMovieIndex = self.movies.firstIndex(where: { $0.id == movie.id }) {
            self.movies[currentMovieIndex].favorite = movie.favorite
        }

        self.collectionView.reloadData()
    }

}

// MARK: - FavoriteMoviesActions

extension MainViewController: FavoriteMoviesActions {

    func favoriteDeleted(_ movie: Movie) {
        if let currentMovieIndex = self.movies.firstIndex(where: { $0.id == movie.id }) {
            self.movies[currentMovieIndex].favorite = false
        }

        self.collectionView.reloadData()
    }

}
