////
////  ShowMoviesPresenterTests.swift
////  Movs
////
////  Created by Miguel Pimentel on 25/09/19.
////  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
////
//
//@testable import Movs
//import XCTest
//
//class ShowMoviesPresenterTests: XCTestCase {
//    // MARK: Subject under test
//
//    var sut: ShowMoviesPresenter!
//
//    // MARK: Test lifecycle
//
//    override func setUp() {
//        super.setUp()
//        setupShowMoviesPresenter()
//    }
//
//    override func tearDown() {
//        super.tearDown()
//    }
//
//    // MARK: Test setup
//
//    func setupShowMoviesPresenter() {
//        sut = ShowMoviesPresenter()
//    }
//
//    // MARK: Test doubles
//
//    class ShowMoviesDisplayLogicSpy: ShowMoviesDisplayLogic {
//        var displaySomethingCalled = false
//
//        func displaySomething(viewModel: ShowMovies.Something.ViewModel) {
//            displaySomethingCalled = true
//        }
//    }
//
//    // MARK: Tests
//
//    func testPresentSomething() {
//        // Given
//        let spy = ShowMoviesDisplayLogicSpy()
//        sut.viewController = spy
//        let response = ShowMovies.Something.Response()
//
//        // When
//        sut.presentSomething(response: response)
//
//        // Then
//        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
//    }
//}
