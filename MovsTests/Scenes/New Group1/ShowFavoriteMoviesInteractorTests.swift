////
////  ShowFavoriteMoviesInteractorTests.swift
////  Movs
////
////  Created by Miguel Pimentel on 24/09/19.
////  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
////

@testable import Movs
import XCTest

class ShowFavoriteMoviesInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ShowFavoriteMoviesInteractor!
    var spy: ShowFavoriteMoviesPresentationLogicSpy?
    
    let expectation = XCTestExpectation(description: "Movie Info Fetched")
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupMovieDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMovieDetailInteractor() {
        sut = ShowFavoriteMoviesInteractor()
        spy = ShowFavoriteMoviesPresentationLogicSpy(tester: self)
        sut.presenter = spy
    }
    
    // MARK:  - Test doubles
    
    class ShowFavoriteMoviesPresentationLogicSpy: ShowFavoriteMoviesPresentationLogic {
        
        var tester: ShowFavoriteMoviesInteractorTests?
        
        init(tester: ShowFavoriteMoviesInteractorTests) {
            self.tester = tester
        }
        
        var presentFavoriteMoviesCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        var presentUpdatedFavoriteMoviesCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        func presentFavoriteMovies(response: ShowFavoriteMovies.FetchFavoriteMovies.Response) {
            self.presentFavoriteMoviesCalled = true
        }
        
        func presentUpdatedFavoriteMovies(response: ShowFavoriteMovies.UnfavoriteMovie.Response) {
            self.presentUpdatedFavoriteMoviesCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testFetchMovieDetails() {
  
        let fetchFavoriteMoviesRequest = ShowFavoriteMovies.FetchFavoriteMovies.Request()
        let updateFavoriteMoviesRequest = ShowFavoriteMovies.UnfavoriteMovie.Request(movie: Movie(id: 1,
                                                                                                  imageUrl:nil,
                                                                                                  posterImageUrl: nil,
                                                                                                  title: nil,
                                                                                                  overview: nil,
                                                                                                  release: nil,
                                                                                                  rate: nil,
                                                                                                  genres: nil,
                                                                                                  language: nil,
                                                                                                  movieLength: nil,
                                                                                                  isFavorite: nil,
                                                                                                  category: .popular))
        
        
        sut.fetchFavoriteMovies(request: fetchFavoriteMoviesRequest)
        sut.unfavoriteMovie(request: updateFavoriteMoviesRequest)
        
        wait(for: [self.expectation], timeout: 20)
    }
}
