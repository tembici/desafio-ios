//
//  TabsPresenter.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class TabsPresenter {

    private let view: TabsViewToPresenter
    private lazy var interactor: TabsInteractorToPresenter = {
        return TabsInteractor(presenter: self)
    }()

    init (view: TabsViewToPresenter) {
        self.view = view
    }

}

// MARK: - TabsPresenterToView

extension TabsPresenter: TabsPresenterToView {

    func viewDidLoad() {

    }

}

// MARK: - TabsPresenterToInteractor

extension TabsPresenter: TabsPresenterToInteractor {

}
