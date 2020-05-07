//
//  MainViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tryGetMoviesAgainButton: UIButton!
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    private let emptyStateMessage = "Your search for \"#text#\" returned no results"


    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    private var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private var rowTapped: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.showAnimatedGradientSkeleton()
        self.presenter.viewDidLoad()

        self.collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = self.rowTapped, row < self.movies.count else { return }
        guard let viewController = segue.destination as? MovieDetailViewController else { return }

        viewController.movieToShow = self.movies[row]
    }

    @IBAction func tryGetMoviesAgainTapped(_ sender: Any) {
        self.tryGetMoviesAgainButton.isHidden = true
        self.presenter.tryToGetMoviesTapped()
    }
}

extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterMovies(with: searchBar.text)
    }

}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowTapped = indexPath.row
        self.performSegue(withIdentifier: "segueToMovieDetail", sender: self)
    }

}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

        cell.updateData(with: self.movies[indexPath.row])
        cell.delegate = self

        if indexPath.row == self.movies.count - 1 {
            self.presenter.fetchMoreMovies()
        }

        return cell
    }

}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

    func updateMovies(with movies: [Movie]) {
        if movies.count > 0 {
            self.movies.append(contentsOf: movies)
        }

        DispatchQueue.main.async { [weak self] in
            self?.collectionView.hideSkeleton()
        }

        if self.movies.count == 0 {
            if let searchQuery = self.searchBar.text, !searchQuery.isEmpty {
                let message = self.emptyStateMessage.replacingOccurrences(of: "#text#", with: searchQuery)
                self.emptyStateLabel.text = message
            } else {
                self.emptyStateLabel.text = "No movies found"
            }

            DispatchQueue.main.async { [weak self] in
                self?.emptyStateView.isHidden = false
            }

        } else {
            DispatchQueue.main.async { [weak self] in
                self?.emptyStateView.isHidden = true
            }
        }
    }

    func removeMovies() {
        self.movies = []
    }

    func showErrorState() {
        let title = "Error on get movies"
        let message = "You can try get movies again"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let tryAgainTitle = "Try again"
        let tryAgainAction = UIAlertAction(title: tryAgainTitle, style: .default) { _ in
            self.presenter.tryToGetMoviesTapped()
        }

        alert.addAction(tryAgainAction)

        let cancelTitle = "Cancel"
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            self.tryGetMoviesAgainButton.isHidden = false
        }

        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

}

extension MainViewController: MovieColletionViewCellDelegate {

    func favoriteChanged(movie: Movie, imageData: Data?) {
        self.presenter.favoriteChanged(movie: movie, imageData: imageData)
    }

}
