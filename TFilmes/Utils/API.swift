//
//  API.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class API {

    static let instance = API()

    private init() {}

    private let urlString = "https://api.themoviedb.org/3"
    private let imageUrlString = "https://image.tmdb.org/t/p/w185"

    private lazy var defaultQueryItems = [
        URLQueryItem(name: "api_key", value: ProcessInfo.processInfo.environment["api_key"])
    ]

    func get(
        path: String,
        query: [URLQueryItem] = [],
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        guard var urlComponenet = URLComponents(string: "\(self.urlString)\(path)") else { return }

        var queryItems = self.defaultQueryItems
        queryItems.append(contentsOf: query)

        urlComponenet.queryItems = queryItems

        guard let url = urlComponenet.url else { return }

        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }

    func generateImageURL(path: String?) -> URL? {
        let imagePath = path ?? ""
        return URL(string: "\(self.imageUrlString)\(imagePath)")
    }

}
