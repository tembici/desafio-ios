//
//  Movie.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import UIKit

class Movie {

    let id: Int
    let overview: String
    let releaseDate: Date?
    let genreIds: [Int]
    let originalTitle: String
    let imageURL: URL?
    var favorite: Bool

    var image: UIImage?

    var genres: [String] {
        return GenreModel.find(byIdIn: self.genreIds).compactMap { $0.name }
    }

    init(
        id: Int,
        overview: String,
        releaseDate: Date?,
        genreIds: [Int],
        originalTitle: String,
        imageURL: URL?,
        favorite: Bool
    ) {
        self.id = id
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.originalTitle = originalTitle
        self.imageURL = imageURL
        self.favorite = favorite
    }

    init(movieResponse: MovieResponse, imageURL: URL?, favorite: Bool) {
        self.id = movieResponse.id
        self.overview = movieResponse.overview

        if let releaseDate = movieResponse.release_date {
            self.releaseDate = Date(from: releaseDate, format: "yyyy-MM-dd")
        } else {
            self.releaseDate = nil
        }

        self.genreIds = movieResponse.genre_ids
        self.originalTitle = movieResponse.original_title

        self.imageURL = imageURL
        self.favorite = favorite
    }

    func getImage(completion: @escaping ((_ image: UIImage?) -> Void)) {
        if let image = self.image {
            completion(image)
        } else {
            self.downloadImage(completion: completion)
        }
    }

    private func downloadImage(completion: @escaping ((_ image: UIImage?) -> Void)) {
        DispatchQueue.global().async { [self] in
            guard let imageURL = self.imageURL,
                let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
                }

            self.image = image
            completion(image)
        }
    }

}
