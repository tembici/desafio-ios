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

    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    private var movies: [Movie] = []

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

        debugPrint(indexPath.row)
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        DispatchQueue.main.async { [weak self] in
            self?.collectionView.hideSkeleton()
        }

        if self.movies.count == 0 {
            if let searchQuery = self.searchBar.text, !searchQuery.isEmpty {
                let baseMessage = NSLocalizedString("main.empty.search", comment: "Search base string")
                let message = baseMessage.replacingOccurrences(of: "#text#", with: searchQuery)
                self.emptyStateLabel.text = message
            } else {
                self.emptyStateLabel.text = NSLocalizedString("main.empty.default", comment: "Default empty")
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
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func showErrorState() {
        let title = NSLocalizedString("main.error.title", comment: "Error title")
        let message = NSLocalizedString("main.error.message", comment: "Error message")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let tryAgainTitle = NSLocalizedString("main.error.try_agin", comment: "Error try again button")
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

extension MainViewController: MovieColletionViewCellDelegate {

    func favoriteChanged(movie: Movie, imageData: Data?) {
        if let currentMovieIndex = self.movies.firstIndex(where: { $0.id == movie.id }) {
            self.movies[currentMovieIndex].favorite = movie.favorite
        }

        self.presenter.favoriteChanged(movie: movie, imageData: imageData)
    }

}
