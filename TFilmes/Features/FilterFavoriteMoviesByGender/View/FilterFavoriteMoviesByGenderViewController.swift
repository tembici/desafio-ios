//
//  FilterFavoriteMoviesByGenderViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class FilterFavoriteMoviesByGenderViewController: UIViewController {

    private lazy var presenter: FilterFavoriteMoviesByGenderPresenterToView = {
        return FilterFavoriteMoviesByGenderPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

}

// MARK: - FilterFavoriteMoviesByGenderViewToPresenter

extension FilterFavoriteMoviesByGenderViewController: FilterFavoriteMoviesByGenderViewToPresenter {

}
