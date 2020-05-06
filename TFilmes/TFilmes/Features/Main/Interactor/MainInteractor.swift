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

    private let urlPath = "/movie/popular"
    private let urlString = "https://api.themoviedb.org/3"

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

    func fetchMoviesOnApi(with page: Int) {
        guard var urlComponenet = URLComponents(string: "\(self.urlString)\(self.urlPath)") else { return }

        urlComponenet.queryItems = [
            URLQueryItem(name: "api_key", value: "38187d3597431e7cbcc9a5985aacf2cc"),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = urlComponenet.url else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let data = data else { return }

            do {
               let res = try JSONDecoder().decode(MoviePopularResponse.self, from: data)
                debugPrint(res)
            } catch let error {
                debugPrint(error)
            }


        }.resume()

    }
}
