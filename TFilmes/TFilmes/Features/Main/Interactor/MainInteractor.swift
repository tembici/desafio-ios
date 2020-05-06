//
//  MainInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainInteractor {

    private let presenter: MainPresenterToInteractor

    init (presenter: MainPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

}
