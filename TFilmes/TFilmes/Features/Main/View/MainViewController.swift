//
//  MainViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

}
