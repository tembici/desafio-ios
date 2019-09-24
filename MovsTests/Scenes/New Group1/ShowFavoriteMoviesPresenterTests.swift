////
////  ShowFavoriteMoviesPresenterTests.swift
////  Movs
////
////  Created by Miguel Pimentel on 24/09/19.
////  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
////

@testable import Movs
import XCTest

class ShowFavoriteMoviesPresenterTests: XCTestCase {

    // MARK: Subject under test
    
    var sut: ShowFavoriteMoviesPresenter!
    let spy: ShowFavoriteMoviesDisplayLogicSpy = ShowFavoriteMoviesDisplayLogicSpy()
    
    // MARK: Test Lifecycle
    
    override func setUp() {
        super.setUp()
        setupMovieDetailPresenter()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupMovieDetailPresenter() {
        sut = ShowFavoriteMoviesPresenter()
        sut.viewController = spy
    }
    
    // MARK: Test
    
    class ShowFavoriteMoviesDisplayLogicSpy: ShowFavoriteMoviesDisplayLogic {
        
        var displayFavoriteMoviesCalled = false
        var displayUpdatedFavoriteMoviesCalled = false
        
        func displayFavoriteMovies(viewModel: ShowFavoriteMovies.FetchFavoriteMovies.ViewModel) {
            self.displayFavoriteMoviesCalled = true
        }
        
        func displayUpdatedFavoriteMovies(viewModel: ShowFavoriteMovies.UnfavoriteMovie.ViewModel) {
            self.displayUpdatedFavoriteMoviesCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentMovieDetail() {
        
        let favoriteMoviesResponse = ShowFavoriteMovies.FetchFavoriteMovies.Response(content: [])
        let updateFavoriteMoviesResponse = ShowFavoriteMovies.UnfavoriteMovie.Response(content: [])

        sut.presentFavoriteMovies(response: favoriteMoviesResponse)
        sut.presentUpdatedFavoriteMovies(response: updateFavoriteMoviesResponse)
        
        XCTAssertTrue(spy.displayFavoriteMoviesCalled, "displayFavoriteMovies(viewModel:) should ask the view controller to display the result")
        XCTAssertTrue(spy.displayUpdatedFavoriteMoviesCalled, "displayUpdatedFavoriteMovies(viewMdel:) should ask the view controller to display the result")
    }
}
