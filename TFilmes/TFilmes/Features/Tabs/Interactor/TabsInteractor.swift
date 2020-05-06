//
//  TabsInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class TabsInteractor {

    private let presenter: TabsPresenterToInteractor

    init (presenter: TabsPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - TabsInteractorToPresenter

extension TabsInteractor: TabsInteractorToPresenter {

}
