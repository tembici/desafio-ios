//
//  FilterByYearTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 08/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes
import RealmSwift

class FilterByYearTests: XCTestCase {

    var presenter: FilterFavoriteMoviesByYearPresenter!
    var viewToPresenter: FilterFavoriteMoviesByYearViewToPresenterTest!

    override func setUpWithError() throws {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "db-test"
        self.viewToPresenter = FilterFavoriteMoviesByYearViewToPresenterTest()
        self.presenter = FilterFavoriteMoviesByYearPresenter(view: self.viewToPresenter)
    }

    override class func tearDown() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }

}

extension FilterByYearTests {

    func testReturnAllYearsInFilter() throws {
        let expectation = self.expectation(description: "Get all years")

        let expectedDate1 = Date(from: "2001-01-01", format: "yyyy-MM-dd")!
        let expectedDate2 = Date(from: "2002-01-01", format: "yyyy-MM-dd")!

        FakerMovie.saveInDB(FakerMovie.generate(releaseDate: expectedDate1))
        FakerMovie.saveInDB(FakerMovie.generate(releaseDate: expectedDate2))

        self.viewToPresenter.completion = {
            XCTAssertEqual(self.viewToPresenter.years.count, 2)

            XCTAssertTrue(self.viewToPresenter.years.contains(expectedDate1.getYear()))
            XCTAssertTrue(self.viewToPresenter.years.contains(expectedDate2.getYear()))
            expectation.fulfill()
        }

        self.presenter.viewDidLoad()

        waitForExpectations(timeout: 5, handler: nil)
    }

}

extension FilterByYearTests {

    class FilterFavoriteMoviesByYearViewToPresenterTest: FilterFavoriteMoviesByYearViewToPresenter {
        var years: [Int] = []

        var completion: (() -> ())?

        func updateYears(with years: [Int]) {
            self.years = years
            self.completion?()
        }
    }

}
