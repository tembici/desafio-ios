//
//  FilterFavoriteMoviesViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class FilterFavoriteMoviesViewController: UITableViewController {

    weak var delegate: FilterFavoriteMoviesDelegate?

    var yearsFilter: [Int] = []
    var genreIdsFilter: [Int] = []

    private let segueToFilterByYear = "segueToFilterByYear"
    private let segueToFilterByGenre = "segueToFilterByGenre"

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case self.segueToFilterByYear: self.prepareYearFilter(segue.destination)
        case self.segueToFilterByGenre: self.prepareGenreFilter(segue.destination)
        default: break
        }
    }

    private func prepareYearFilter(_ destination: UIViewController) {
        guard let view = destination as? FilterFavoriteMoviesByYearViewController else { return }
        view.delegate = self
        view.yearsSelected = self.yearsFilter
    }

    private func prepareGenreFilter(_ destination: UIViewController) {
        guard let view = destination as? FilterFavoriteMoviesByGenreViewController else { return }
        view.delegate = self
        view.genreIdsSelected = self.genreIdsFilter
    }

}

// MARK: - Actions

extension FilterFavoriteMoviesViewController {

    @objc private func applyTapped() {
        self.delegate?.applyFiltersTapped(years: self.yearsFilter, genreIds: self.genreIdsFilter)
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - FilterFavoriteMoviesByYearDelegate

extension FilterFavoriteMoviesViewController: FilterFavoriteMoviesByYearDelegate {

    func yearApplyTapped(_ years: [Int]) {
        self.yearsFilter = years
    }

}

// MARK: - FilterFavoriteMoviesByGenreDelegate

extension FilterFavoriteMoviesViewController: FilterFavoriteMoviesByGenreDelegate {

    func genreApplyTapped(_ genreIds: [Int]) {
        self.genreIdsFilter = genreIds
    }

}
