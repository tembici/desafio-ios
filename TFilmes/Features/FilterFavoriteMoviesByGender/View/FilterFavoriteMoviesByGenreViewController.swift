//
//  FilterFavoriteMoviesByGenreViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class FilterFavoriteMoviesByGenreViewController: UITableViewController {

    private lazy var presenter: FilterFavoriteMoviesByGenrePresenterToView = {
        return FilterFavoriteMoviesByGenrePresenter(view: self)
    }()

    private var genres: [GenreFilterItem] = []
    var genreIdsSelected: [Int] = []
    weak var delegate: FilterFavoriteMoviesByGenreDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barButton = UIBarButtonItem(
            title: NSLocalizedString("apply", comment: "Apply word"),
            style: .done,
            target: self,
            action: #selector(applyTapped)
        )

        self.navigationItem.rightBarButtonItem = barButton
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

}

// MARK: - Actions

extension FilterFavoriteMoviesByGenreViewController {

    @objc func applyTapped() {
        self.delegate?.genreApplyTapped(self.genreIdsSelected)
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - TableView

extension FilterFavoriteMoviesByGenreViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = self.genres[indexPath.row]

        if let index = self.genreIdsSelected.firstIndex(of: genre.id) {
            self.genreIdsSelected.remove(at: index)
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            self.genreIdsSelected.append(genre.id)
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GenreFilterTableViewCell.identifier,
            for: indexPath
        ) as! GenreFilterTableViewCell

        let genre = self.genres[indexPath.row]

        cell.genderLabel.text = genre.name

        if self.genreIdsSelected.contains(genre.id) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

}

// MARK: - FilterFavoriteMoviesByGenreViewToPresenter

extension FilterFavoriteMoviesByGenreViewController: FilterFavoriteMoviesByGenreViewToPresenter {

    func updateGenres(with genres: [GenreFilterItem]) {
        self.genres = genres
        self.tableView.reloadData()
    }

}
