//
//  TFilmesUITests.swift
//  TFilmesUITests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
import RealmSwift

class TFilmesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func setUpWithError() throws {

        continueAfterFailure = false
    }

    func testLoadMoviesFromAPI() throws {
        let firstMovieLabel = app.collectionViews.cells.staticTexts["movie-title"].firstMatch

        XCTAssertTrue(firstMovieLabel.waitForExistence(timeout: 10))
    }

    func testShowMovieDetails() throws {
        let firstMovieLabel = app.collectionViews.cells.staticTexts["movie-title"].firstMatch
        let firstMovieLabelText = firstMovieLabel.label

        XCTAssertTrue(firstMovieLabel.waitForExistence(timeout: 10))

        firstMovieLabel.tap()

        let movieTitleLabel = app.staticTexts["movie-title"].firstMatch

        XCTAssertTrue(movieTitleLabel.waitForExistence(timeout: 10))
        XCTAssertEqual(firstMovieLabelText, movieTitleLabel.label)
    }

    func testFavoriteMovieInMainAndShowItFavoritList() throws {
        self.clearFavorites()

        let firstCell = app.collectionViews.cells.firstMatch

        let firstMovieLabel = firstCell.staticTexts["movie-title"].firstMatch

        XCTAssertTrue(firstMovieLabel.waitForExistence(timeout: 10))

        let movieTitle = firstMovieLabel.label

        firstCell.buttons["movie-favorite-button"].tap()

        app.buttons["Favorites Button"].tap()

        XCTAssertTrue(app.tables.cells.staticTexts[movieTitle].firstMatch.waitForExistence(timeout: 3))
    }

    func testUnfavoriteMovie() throws {
        self.clearFavorites()

        let firstCollectionCell = app.collectionViews.cells.firstMatch

        let firstMovieLabel = firstCollectionCell.staticTexts["movie-title"].firstMatch

        XCTAssertTrue(firstMovieLabel.waitForExistence(timeout: 10))

        let movieTitle = firstMovieLabel.label
        firstCollectionCell.buttons["movie-favorite-button"].firstMatch.tap()

        app.buttons["Favorites Button"].tap()

        XCTAssertTrue(app.tables.firstMatch.waitForExistence(timeout: 2))
        let movieFavoriteCell = app.tables.cells.firstMatch
        XCTAssertTrue(movieFavoriteCell.staticTexts[movieTitle].exists)

        movieFavoriteCell.swipeLeft()
        movieFavoriteCell.buttons.firstMatch.tap()

        XCTAssertFalse(movieFavoriteCell.staticTexts[movieTitle].exists)
    }

    private func clearFavorites() {
        app.buttons["Favorites Button"].tap()

        defer {
            app.buttons["Movies Button"].tap()
        }

        guard app.tables.firstMatch.waitForExistence(timeout: 2) else { return }

        while app.tables.cells.count > 0 {
            let cell = app.tables.cells.firstMatch
            cell.swipeLeft()
            cell.buttons.firstMatch.tap()
        }
    }

}
