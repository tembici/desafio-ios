//
//  FilterFavoriteMoviesByYearViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class FilterFavoriteMoviesByYearViewController: UITableViewController {

    private lazy var presenter: FilterFavoriteMoviesByYearPresenterToView = {
        return FilterFavoriteMoviesByYearPresenter(view: self)
    }()

    private var years: [Int] = []
    var yearsSelected: [Int] = []
    weak var delegate: FilterFavoriteMoviesByYearDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

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

}

// MARK: - Actions

extension FilterFavoriteMoviesByYearViewController {

    @objc func applyTapped() {
        self.delegate?.yearApplyTapped(self.yearsSelected)
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - TableView

extension FilterFavoriteMoviesByYearViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let year = self.years[indexPath.row]

        if let index = self.yearsSelected.firstIndex(of: year) {
            self.yearsSelected.remove(at: index)
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            self.yearsSelected.append(year)
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.years.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: YearFilterTableViewCell.identifier,
            for: indexPath
        ) as! YearFilterTableViewCell

        let year = self.years[indexPath.row]

        cell.yearLabel.text = String(year)

        if self.yearsSelected.contains(year) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

}

// MARK: - FilterFavoriteMoviesByYearViewToPresenter

extension FilterFavoriteMoviesByYearViewController: FilterFavoriteMoviesByYearViewToPresenter {

    func updateYears(with years: [Int]) {
        self.years = years
        self.tableView.reloadData()
    }

}
