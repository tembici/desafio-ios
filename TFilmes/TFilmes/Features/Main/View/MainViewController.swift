//
//  MainViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    private var mainMovies: [MainMovie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private var rowTapped: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()

        self.collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = self.rowTapped, row < self.mainMovies.count else { return }
        guard let viewController = segue.destination as? MovieDetailViewController else { return }

        viewController.movieToShow = self.mainMovies[row]
    }

}

extension MainViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterMainMovies(with: searchBar.text)
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
        return self.mainMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath as IndexPath) as! MovieCollectionViewCell

        cell.updateData(with: self.mainMovies[indexPath.row])
        cell.delegate = self

        if indexPath.row == self.mainMovies.count - 1 {
            self.presenter.fetchMoreMovies()
        }

        return cell
    }

}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

    func updateMovies(with mainMovies: [MainMovie]) {
        self.mainMovies.append(contentsOf: mainMovies)
    }

    func removeMovies() {
        self.mainMovies = []
    }

}

extension MainViewController: MovieColletionViewCellDelegate {

    func favoriteChanged(mainMovie: MainMovie) {
        self.presenter.favoriteChanged(mainMovie: mainMovie)
    }

}
