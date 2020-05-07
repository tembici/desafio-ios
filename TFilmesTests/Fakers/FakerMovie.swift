//
//  FakerMovie.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import Fakery
@testable import TFilmes

final class FakerMovie {

    private static let faker = Faker()

    static func generate(
        id: Int? = nil,
        overview: String? = nil,
        releaseDate: Date? = nil,
        genreIds: [Int]? = nil,
        originalTitle: String? = nil,
        imageURL: URL? = nil,
        favorite: Bool? = nil
    ) -> Movie {
        return Movie(
            id: id ?? self.faker.number.randomInt(),
            overview: overview ?? self.faker.lorem.paragraph(),
            releaseDate: releaseDate ?? self.faker.date.backward(days: self.faker.number.randomInt()),
            genreIds: genreIds ?? [],
            originalTitle: originalTitle ?? self.faker.name.name(),
            imageURL: imageURL,
            favorite: self.faker.number.randomBool()
        )
    }

    static func generate(
        quantity: Int,
        id: Int? = nil,
        overview: String? = nil,
        releaseDate: Date? = nil,
        genreIds: [Int]? = nil,
        originalTitle: String? = nil,
        imageURL: URL? = nil,
        favorite: Bool? = nil
    ) -> [Movie] {
        var fakeMovies: [Movie] = []

        for _ in 0..<quantity {
            let movie = self.generate(
                id: id,
                overview: overview,
                releaseDate: releaseDate,
                genreIds: genreIds,
                originalTitle: originalTitle,
                imageURL: imageURL,
                favorite: favorite
            )

            fakeMovies.append(movie)
        }

        return fakeMovies
    }

    
}
