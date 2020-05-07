//
//  MovieDetailViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private lazy var presenter: MovieDetailPresenterToView = {
        return MovieDetailPresenter(view: self)
    }()

    @IBOutlet weak var movieTitleLabel: UILabel!

    var movieToShow: MainMovie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.movieTitleLabel.text = self.movieToShow?.originalTitle
    }

}

// MARK: - MovieDetailViewToPresenter

extension MovieDetailViewController: MovieDetailViewToPresenter {

}
