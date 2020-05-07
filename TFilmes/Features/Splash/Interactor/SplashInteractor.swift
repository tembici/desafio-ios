//
//  SplashInteractor.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class SplashInteractor {

    unowned private let presenter: SplashPresenterToInteractor

    init (presenter: SplashPresenterToInteractor) {
        self.presenter = presenter
    }

    private let genrePath = "/genre/movie/list"

    private func saveGenres(_ genres: [GenreResponse]) {
        for genre in genres {
            GenreModel.create(id: genre.id, name: genre.name)
        }

        self.presenter.didFetchGenres()
    }

}

// MARK: - SplashInteractorToPresenter

extension SplashInteractor: SplashInteractorToPresenter {

    func fetchGenres() {
        API.instance.get(path: self.genrePath) { [weak self] (data, _, error) in
            if let error = error {
                debugPrint(error)
                self?.presenter.didFailToFetchGenres()
                return
            }

            guard let data = data else {
                self?.presenter.didFailToFetchGenres()
                return
            }

            do {
                let res = try JSONDecoder().decode(GenresResponse.self, from: data)

                self?.saveGenres(res.genres)
            } catch let error {
                debugPrint(error)
                self?.presenter.didFailToFetchGenres()
            }
        }
    }

}
