////
////  ShowMoviesInteractorTests.swift
////  Movs
////
////  Created by Miguel Pimentel on 25/09/19.
////  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
////
//
//@testable import Movs
//import XCTest
//
//class ShowMoviesInteractorTests: XCTestCase {
//    // MARK: Subject under test
//
//    var sut: ShowMoviesInteractor!
//
//    // MARK: Test lifecycle
//
//    override func setUp() {
//        super.setUp()
//        setupShowMoviesInteractor()
//    }
//
//    override func tearDown() {
//        super.tearDown()
//    }
//
//    // MARK: Test setup
//
//    func setupShowMoviesInteractor() {
//        sut = ShowMoviesInteractor()
//    }
//
//    // MARK: Test doubles
//
//    class ShowMoviesPresentationLogicSpy: ShowMoviesPresentationLogic {
//        var presentSomethingCalled = false
//
//        func presentSomething(response: ShowMovies.Something.Response) {
//            presentSomethingCalled = true
//        }
//    }
//
//    // MARK: Tests
//
//    func testDoSomething() {
//        // Given
//        let spy = ShowMoviesPresentationLogicSpy()
//        sut.presenter = spy
//        let request = ShowMovies.Something.Request()
//
//        // When
//        sut.doSomething(request: request)
//
//        // Then
//        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
//    }
//}
