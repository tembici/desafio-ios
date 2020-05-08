//
//  FavoriteTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes
import RealmSwift

class FavoriteTests: XCTestCase {

    var presenter: FavoriteMoviesPresenter!
    var viewToPresenter: FavoriteMoviesViewToPresenterTest!

    override func setUpWithError() throws {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "db-test"
        self.viewToPresenter = FavoriteMoviesViewToPresenterTest()
        self.presenter = FavoriteMoviesPresenter(view: self.viewToPresenter)
    }

    override func tearDownWithError() throws {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }

}

extension FavoriteTests {

    func testGetAllFavoriteMovies() {
        let expectation = self.expectation(description: "Get movies")
        let fakerMovies = FakerMovie.generate(quantity: 3)
        FakerMovie.saveInDB(fakerMovies)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, fakerMovies.count)
            expectation.fulfill()
        }

        self.presenter.viewDidAppear()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testShowRemoveFilterWhenOnlyYearFilterIsSet() throws {
        let expectation = self.expectation(description: "Show remove filter")

        self.viewToPresenter.setRemoveFilterIsVisibleCompletion = {
            XCTAssertTrue(self.viewToPresenter.showRemoveFilter)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [123], genreIds: [])
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testShowRemoveFilterWhenOnlyGenreIdFilterIsSet() throws {
        let expectation = self.expectation(description: "Show remove filter")

        self.viewToPresenter.setRemoveFilterIsVisibleCompletion = {
            XCTAssertTrue(self.viewToPresenter.showRemoveFilter)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [], genreIds: [123])
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testShowRemoveFilterWhenAllFilterIsSet() throws {
        let expectation = self.expectation(description: "Show remove filter")

        self.viewToPresenter.setRemoveFilterIsVisibleCompletion = {
            XCTAssertTrue(self.viewToPresenter.showRemoveFilter)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [123], genreIds: [123])
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testHideRemoveFilterWhenAllFilterIsRemoved() throws {
        let expectation = self.expectation(description: "Hide remove filter")

        self.viewToPresenter.setRemoveFilterIsHidenCompletion = {
            XCTAssertFalse(self.viewToPresenter.showRemoveFilter)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [], genreIds: [])
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testReturnOnlyFavoritesFilteredByYear() {
        let expectation = self.expectation(description: "Get movies")

        let anyDate = Date(from: "2000-01-01", format: "yyyy-MM-dd")!
        let fakerMovies = FakerMovie.generate(quantity: 3, releaseDate: anyDate)

        FakerMovie.saveInDB(fakerMovies)

        let expectedDate = Date(from: "1994-05-09", format: "yyyy-MM-dd")!
        let expectedMovie = FakerMovie.generate(releaseDate: expectedDate)

        FakerMovie.saveInDB(expectedMovie)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 1)
            XCTAssertEqual(self.viewToPresenter.movies[0].id, expectedMovie.id)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [expectedDate.getYear()], genreIds: [])

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testReturnOnlyFavoritesFilteredByGenre() {
        let expectation = self.expectation(description: "Get movies")

        let anyGenre = FakeGenreModel.generate(id: 1)
        let fakerMovies = FakerMovie.generate(quantity: 3, genreIds: [anyGenre.id])

        FakerMovie.saveInDB(fakerMovies)

        let expectedGenre = FakeGenreModel.generate(id: 2)
        let expectedMovie = FakerMovie.generate(genreIds: [expectedGenre.id])

        FakerMovie.saveInDB(expectedMovie)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 1)
            XCTAssertEqual(self.viewToPresenter.movies[0].id, expectedMovie.id)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [], genreIds: [expectedGenre.id])

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testReturnOnlyFavoritesFilteredByYearAndGenre() {
        let expectation = self.expectation(description: "Get movies")

        let expectedDate = Date(from: "1994-05-09", format: "yyyy-MM-dd")!
        let expectedGenre = FakeGenreModel.generate(id: 2)

        let fakerMovieWithSameYear = FakerMovie.generate(quantity: 3, releaseDate: expectedDate)
        FakerMovie.saveInDB(fakerMovieWithSameYear)

        let fakerMovieWithSameGenre = FakerMovie.generate(quantity: 3, genreIds: [expectedGenre.id])
        FakerMovie.saveInDB(fakerMovieWithSameGenre)

        let expectedMovie = FakerMovie.generate(releaseDate: expectedDate, genreIds: [expectedGenre.id])

        FakerMovie.saveInDB(expectedMovie)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 1)
            XCTAssertEqual(self.viewToPresenter.movies[0].id, expectedMovie.id)
            expectation.fulfill()
        }

        self.presenter.filterUpdated(years: [expectedDate.getYear()], genreIds: [expectedGenre.id])

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testReturnAllMoviesInSelectedYears() {
        let expectation = self.expectation(description: "Get movies")

        let notExpectedDate = Date(from: "2000-01-01", format: "yyyy-MM-dd")!
        let expectedDate1 = Date(from: "2001-01-01", format: "yyyy-MM-dd")!
        let expectedDate2 = Date(from: "2002-01-01", format: "yyyy-MM-dd")!

        let notExpectedMovie = FakerMovie.generate(releaseDate: notExpectedDate)
        FakerMovie.saveInDB(notExpectedMovie)

        let expectedMovie1 = FakerMovie.generate(releaseDate: expectedDate1)
        FakerMovie.saveInDB(expectedMovie1)

        let expectedMovie2 = FakerMovie.generate(releaseDate: expectedDate2)
        FakerMovie.saveInDB(expectedMovie2)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 2)

            let movie1 = self.viewToPresenter.movies.first(where: { $0.id == expectedMovie1.id })
            XCTAssertNotNil(movie1)

            let movie2 = self.viewToPresenter.movies.first(where: { $0.id == expectedMovie2.id })
            XCTAssertNotNil(movie2)

            expectation.fulfill()
        }

        let yearsFilter = [expectedDate1.getYear(), expectedDate2.getYear()]

        self.presenter.filterUpdated(years: yearsFilter, genreIds: [])

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testReturnAllMoviesInSelectedGenres() {
        let expectation = self.expectation(description: "Get movies")

        let notExpectedGenre = FakeGenreModel.generate(id: 1)
        let expectedGenre1 = FakeGenreModel.generate(id: 2)
        let expectedGenre2 = FakeGenreModel.generate(id: 3)

        let notExpectedMovie = FakerMovie.generate(genreIds: [notExpectedGenre.id])
        FakerMovie.saveInDB(notExpectedMovie)

        let expectedMovie1 = FakerMovie.generate(genreIds: [expectedGenre1.id])
        FakerMovie.saveInDB(expectedMovie1)

        let expectedMovie2 = FakerMovie.generate(genreIds: [expectedGenre2.id])
        FakerMovie.saveInDB(expectedMovie2)

        let expectedMovie3 = FakerMovie.generate(genreIds: [expectedGenre1.id, expectedGenre2.id])
        FakerMovie.saveInDB(expectedMovie3)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 3)

            let movie1 = self.viewToPresenter.movies.first(where: { $0.id == expectedMovie1.id })
            XCTAssertNotNil(movie1)

            let movie2 = self.viewToPresenter.movies.first(where: { $0.id == expectedMovie2.id })
            XCTAssertNotNil(movie2)

            let movie3 = self.viewToPresenter.movies.first(where: { $0.id == expectedMovie3.id })
            XCTAssertNotNil(movie3)

            expectation.fulfill()
        }

        let genreFilter = [expectedGenre1.id, expectedGenre2.id]

        self.presenter.filterUpdated(years: [], genreIds: genreFilter)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFilterByName() throws {
        let expectation = self.expectation(description: "Get movies")

        let fakeMovies = FakerMovie.generate(quantity: 10, originalTitle: "Foo")

        FakerMovie.saveInDB(fakeMovies)

        let expectedMovie = FakerMovie.generate(originalTitle: "Bar")
        FakerMovie.saveInDB(expectedMovie)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertEqual(self.viewToPresenter.movies.count, 1)
            XCTAssertEqual(self.viewToPresenter.movies[0].id, expectedMovie.id)

            expectation.fulfill()
        }

        self.presenter.filterMovies(with: "Bar")

        waitForExpectations(timeout: 5, handler: nil)
    }

}

extension FavoriteTests {

    class FavoriteMoviesViewToPresenterTest: FavoriteMoviesViewToPresenter {

        var movies: [Movie] = []
        var showRemoveFilter: Bool = false

        var updateMoviesCompletion: (() -> ())?
        var setRemoveFilterIsVisibleCompletion: (() -> ())?
        var setRemoveFilterIsHidenCompletion: (() -> ())?

        func updateMovies(with movies: [Movie]) {
            self.movies.append(contentsOf: movies)
            self.updateMoviesCompletion?()
        }

        func setRemoveFilterIsVisible() {
            self.showRemoveFilter = true
            self.setRemoveFilterIsVisibleCompletion?()
        }

        func setRemoveFilterIsHiden() {
            self.showRemoveFilter = false
            self.setRemoveFilterIsHidenCompletion?()
        }

    }

}
