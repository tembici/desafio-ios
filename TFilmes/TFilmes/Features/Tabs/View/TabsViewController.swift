//
//  TabsViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

class TabsViewController: UIViewController {

    private lazy var presenter: TabsPresenterToView = {
        return TabsPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

}

// MARK: - TabsViewToPresenter

extension TabsViewController: TabsViewToPresenter {

}
