//
//  ShowMoviesPresenterTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 25/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class ShowMoviesPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    
    var sut: ShowMoviesPresenter!
    let spy: ShowMoviesDisplayLogicSpy = ShowMoviesDisplayLogicSpy()
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        setupShowMoviePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupShowMoviePresenter() {
        sut = ShowMoviesPresenter()
        sut.viewController = spy
    }
    
    // MARK: Test
    
    class ShowMoviesDisplayLogicSpy: ShowMoviesDisplayLogic {
        
        var displayMoviesCalled = false
        var displayQueriedMoviesCalled = false
        
        func displayMovies(viewModel: ShowMovies.fetchMovies.ViewModel) {
            self.displayMoviesCalled = true
        }
        
        func displayQueriedMovies(viewModel: ShowMovies.queryMovies.ViewModel) {
            self.displayQueriedMoviesCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentMovieDetail() {
        
        let fetchMoviesResponse = ShowMovies.fetchMovies.Response(content: [Any]())
        let fetchQueriedMoviesResponse = ShowMovies.queryMovies.Response(content: [Any]())
    
        sut.presentMovies(response: fetchMoviesResponse)
        sut.presentQueriedMovies(response: fetchQueriedMoviesResponse)
        
        XCTAssertTrue(spy.displayMoviesCalled, "displayMovies(viewModel:) should ask the view controller to display the result")
        XCTAssertTrue(spy.displayQueriedMoviesCalled, "displayMoviesCalled(viewMdel:) should ask the view controller to display the result")
    }
}
