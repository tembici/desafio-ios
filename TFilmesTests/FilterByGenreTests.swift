//
//  FilterByGenreTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes
import RealmSwift

class FilterByGenreTests: XCTestCase {

    var presenter: FilterFavoriteMoviesByGenrePresenter!
    var viewToPresenter: FilterFavoriteMoviesByGenreViewToPresenterTest!

    override func setUpWithError() throws {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "db-test"
        self.viewToPresenter = FilterFavoriteMoviesByGenreViewToPresenterTest()
        self.presenter = FilterFavoriteMoviesByGenrePresenter(view: self.viewToPresenter)
    }

}

extension FilterByGenreTests {

    func testReturnAllYearsInFilter() throws {
        let expectation = self.expectation(description: "Get all genres")

        let expectedGenre1 = FakeGenreModel.generate(id: 1)
        let expectedGenre2 = FakeGenreModel.generate(id: 2)

        FakerMovie.saveInDB(FakerMovie.generate(genreIds: [expectedGenre1.id]))
        FakerMovie.saveInDB(FakerMovie.generate(genreIds: [expectedGenre2.id]))

        self.viewToPresenter.completion = {
            XCTAssertEqual(self.viewToPresenter.genres.count, 2)

            let genre1 = self.viewToPresenter.genres.first(where: { $0.id == expectedGenre1.id })
            XCTAssertNotNil(genre1)

            let genre2 = self.viewToPresenter.genres.first(where: { $0.id == expectedGenre2.id })
            XCTAssertNotNil(genre2)

            expectation.fulfill()
        }

        self.presenter.viewDidLoad()

        waitForExpectations(timeout: 5, handler: nil)
    }

}

extension FilterByGenreTests {

    class FilterFavoriteMoviesByGenreViewToPresenterTest: FilterFavoriteMoviesByGenreViewToPresenter {
        var genres: [GenreFilterItem] = []

        var completion: (() -> ())?

        func updateGenres(with genres: [GenreFilterItem]) {
            self.genres = genres
            self.completion?()
        }
    }

}
