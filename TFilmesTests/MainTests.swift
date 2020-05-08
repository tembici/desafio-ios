//
//  MainTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes
import RealmSwift

class MainTests: XCTestCase {

    var presenter: MainPresenter!
    var viewToPresenter: MainViewToPresenterTest!

    override func setUpWithError() throws {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "db-test"
        self.viewToPresenter = MainViewToPresenterTest()
        self.presenter = MainPresenter(view: self.viewToPresenter)
    }

    override class func tearDown() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }

}

extension MainTests {

    func testGetDataFromAPI() throws {
        let currentMovies = self.viewToPresenter.movies.count

        let expectation = self.expectation(description: "Returns from API")

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
            expectation.fulfill()
        }

        self.presenter.viewDidAppear()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetMoreDataFromAPI() throws {
        let expectation = self.expectation(description: "Returns from API")

        self.viewToPresenter.updateMoviesCompletion = {
            let current = self.viewToPresenter.movies.count

            self.viewToPresenter.updateMoviesCompletion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertGreaterThan(self.viewToPresenter.movies.count, current)
                expectation.fulfill()
            }

            self.presenter.fetchMoreMovies()
        }

        self.presenter.viewDidAppear()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTryToGetMoreMoviesWithSamePage() throws {
        let expectation = self.expectation(description: "Returns from API")
        let currentMovies = self.viewToPresenter.movies.count
        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertFalse(self.viewToPresenter.hasError)
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
            expectation.fulfill()
        }

        self.presenter.tryToGetMoviesTapped()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFilterMovies() throws {
        let expectation = self.expectation(description: "Returns from API")
        let fakeMovies = FakerMovie.generate(quantity: 10)
        let anyMovie = fakeMovies[3]

        self.presenter.didFetchMoviesOnApi(fakeMovies)

        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertFalse(self.viewToPresenter.hasError)
            let movie = self.viewToPresenter.movies.first(where: { $0.id == anyMovie.id })
            XCTAssertNotNil(movie)
            expectation.fulfill()
        }

        self.presenter.filterMovies(with: anyMovie.originalTitle)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFilterMovieNotExists() throws {
        let expectation = self.expectation(description: "Returns from API")
        self.viewToPresenter.movies = []
        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertFalse(self.viewToPresenter.hasError)
            XCTAssertEqual(self.viewToPresenter.movies.count, 0)
            expectation.fulfill()
        }

        self.presenter.filterMovies(with: "test")
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testErrorIsCalled() throws {
        let expectation = self.expectation(description: "Returns from API")
        self.viewToPresenter.showErrorStateCompletion = {
            XCTAssertTrue(self.viewToPresenter.hasError)
            expectation.fulfill()
        }

        self.presenter.didFailToFetchMovies()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFavoriteMovie() {
        let fakerMovie = FakerMovie.generate()

        fakerMovie.favorite = true

        self.presenter.favoriteChanged(movie: fakerMovie)

        XCTAssertNotNil(FavoriteMovieModel.getBy(id: fakerMovie.id))
    }

    func testUnfavoriteMovie() {
        let fakerMovie = FakerMovie.generate()

        FavoriteMovieModel.create(
            id: fakerMovie.id,
            originalTitle: fakerMovie.originalTitle,
            overview: fakerMovie.overview,
            releaseDate: fakerMovie.releaseDate,
            imageName: fakerMovie.imageURL?.lastPathComponent,
            genreIds: fakerMovie.genreIds
        )

        fakerMovie.favorite = false

        self.presenter.favoriteChanged(movie: fakerMovie)

        XCTAssertNil(FavoriteMovieModel.getBy(id: fakerMovie.id))
    }

}

extension MainTests {

    class MainViewToPresenterTest: MainViewToPresenter {

        var movies: [Movie] = []
        var hasError: Bool = false

        var updateMoviesCompletion: (() -> ())?
        var removeMoviesCompletion: (() -> ())?
        var showErrorStateCompletion: (() -> ())?

        func updateMovies(with movies: [Movie]) {
            self.movies.append(contentsOf: movies)
            self.updateMoviesCompletion?()
        }

        func removeMovies() {
            self.movies = []
            self.removeMoviesCompletion?()
        }

        func showErrorState() {
            self.hasError = true
            self.showErrorStateCompletion?()
        }

    }

}
