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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barButton = UIBarButtonItem(
            title: "apply",
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
        if let viewController = segue.destination as? FilterFavoriteMoviesByYearViewController {
            viewController.yearsSelected = self.yearsFilter
            viewController.delegate = self
        }
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
