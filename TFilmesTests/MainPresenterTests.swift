//
//  MainTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes
@testable import RealmSwift

class MainPresenterTests: XCTestCase {

    var presenter: MainPresenter!
    var viewToPresenter: MainViewToPresenterTest!

    var mainViewController = MainViewController()

    override func setUpWithError() throws {
        super.setUp()

        self.viewToPresenter = MainViewToPresenterTest()
        self.presenter = MainPresenter(view: self.viewToPresenter)
    }

    override func tearDownWithError() throws {

    }

}

// MARK: - MainPresenterToView functions

extension MainPresenterTests {

    func testGetDataFromAPI() throws {
        let currentMovies = self.viewToPresenter.movies.count
        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
        }

        self.presenter.viewDidLoad()
    }

    func testGetMoreDataFromAPI() throws {
        self.viewToPresenter.updateMoviesCompletion = {
            let current = self.viewToPresenter.movies.count

            self.viewToPresenter.updateMoviesCompletion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertGreaterThan(self.viewToPresenter.movies.count, current)
            }

            self.presenter.fetchMoreMovies()

        }

        self.presenter.viewDidLoad()
    }

    func testTryToGetMoreMoviesWithSamePage() throws {
        let currentMovies = self.viewToPresenter.movies.count
        self.viewToPresenter.updateMoviesCompletion = {
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
        }

        self.presenter.tryToGetMoviesTapped()
    }

    func testFilterMovies() throws {
        let fakeMovies = FakerMovie.generate(quantity: 10)
        let anyMovie = fakeMovies[3]

        self.viewToPresenter.updateMoviesCompletion = {
            self.viewToPresenter.updateMoviesCompletion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                let movie = self.viewToPresenter.movies.first(where: { $0.id == anyMovie.id })
                XCTAssertNotNil(movie)
            }

            self.presenter.filterMovies(with: anyMovie.originalTitle)

        }


        self.presenter.didFetchMoviesOnApi(fakeMovies)
    }

    func testFilterMovieNotExists() throws {
        let fakeMovie = FakerMovie.generate()

        self.viewToPresenter.updateMoviesCompletion = {
            self.viewToPresenter.updateMoviesCompletion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertEqual(self.viewToPresenter.movies.count, 0)
            }

            self.presenter.filterMovies(with: "\(fakeMovie.originalTitle) test")
        }
    }

    func testErrorIsCalled() throws {
        self.viewToPresenter.showErrorStateCompletion = {
            XCTAssertTrue(self.viewToPresenter.hasError)
        }

        self.presenter.didFailToFetchMovies()
    }

}

extension MainPresenterTests {

    class MainViewToPresenterTest: MainViewToPresenter {

        var movies: [Movie] = []
        var hasError: Bool = false

        var updateMoviesCompletion: (() -> ())?
        var removeMoviesCompletion: (() -> ())?
        var showErrorStateCompletion: (() -> ())?

        func updateMovies(with movies: [Movie]) {
            self.movies = movies
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

