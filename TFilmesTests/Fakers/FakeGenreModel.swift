//
//  FakeGenreModel.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import Fakery
@testable import TFilmes

final class FakeGenreModel {

    private static let faker = Faker()

    static func generate(
        id: Int? = nil,
        name: String? = nil
    ) -> GenreModel {

        let genreId = id ?? self.faker.number.randomInt()
        let genreName = name ?? self.faker.name.name()
        
        GenreModel.create(id: genreId, name: genreName)

        return GenreModel.getBy(id: genreId)!
    }

    static func generate(
        quantity: Int,
        id: Int? = nil,
        name: String? = nil
    ) -> [GenreModel] {
        var fakeGenres: [GenreModel] = []

        for _ in 0..<quantity {
            let genre = self.generate(
                id: id,
                name: name
            )

            fakeGenres.append(genre)
        }

        return fakeGenres
    }

}
