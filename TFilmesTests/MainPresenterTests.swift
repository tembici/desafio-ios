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
        self.viewToPresenter.completion = {
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
        }

        self.presenter.viewDidLoad()
    }

    func testGetMoreDataFromAPI() throws {
        self.viewToPresenter.completion = {
            let current = self.viewToPresenter.movies.count

            self.viewToPresenter.completion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertGreaterThan(self.viewToPresenter.movies.count, current)
            }

            self.presenter.fetchMoreMovies()

        }

        self.presenter.viewDidLoad()
    }

    func testFilterMovies() throws {
        self.viewToPresenter.completion = {
            let movie = self.viewToPresenter.movies[0]

            self.viewToPresenter.completion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertGreaterThan(self.viewToPresenter.movies.count, 0)
                XCTAssertNotNil(self.viewToPresenter.movies.first(where: { $0.id == movie.id }))
            }

            self.presenter.filterMovies(with: movie.originalTitle)
        }

        self.presenter.viewDidLoad()
    }

    func testFilterMovieNotExists() throws {
        self.viewToPresenter.completion = {
            self.viewToPresenter.completion = {
                XCTAssertFalse(self.viewToPresenter.hasError)
                XCTAssertEqual(self.viewToPresenter.movies.count, 0)
            }

            self.presenter.filterMovies(with: "This film not exists")
        }

        self.presenter.viewDidLoad()
    }

    func testTryToGetMoreMoviesWithSamePage() throws {
        let currentMovies = self.viewToPresenter.movies.count
        self.viewToPresenter.completion = {
            XCTAssertGreaterThan(self.viewToPresenter.movies.count, currentMovies)
        }

        self.presenter.tryToGetMoviesTapped()
    }

}

extension MainPresenterTests {

    class MainViewToPresenterTest: MainViewToPresenter {

        var movies: [Movie] = []
        var hasError: Bool = false

        var completion: (() -> ())?

        func updateMovies(with movies: [Movie]) {
            self.movies = movies
            self.completion?()
        }

        func removeMovies() {
            self.movies = []
            self.completion?()
        }

        func showErrorState() {
            self.hasError = true
            self.completion?()
        }

    }
}

