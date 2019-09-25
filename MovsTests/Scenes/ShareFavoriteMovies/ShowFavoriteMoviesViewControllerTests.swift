//
//  ShowFavoriteMoviesViewControllerTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class ShowFavoriteMoviesViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    
    var sut: ShowFavoriteMoviesViewController!
    let spy = ShowFavoriteMoviesBusinessLogicSpy()
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupShowFavoriteMoviesViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShowFavoriteMoviesViewController() {
        sut =  ShowFavoriteMoviesViewController()
        sut.interactor = spy
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class ShowFavoriteMoviesBusinessLogicSpy: ShowFavoriteMoviesBusinessLogic {
        
        var unfavoriteMoviesCalled = false
        var fetchFavoriteMoviesCalled = false
        
        func fetchFavoriteMovies(request: ShowFavoriteMovies.FetchFavoriteMovies.Request) {
            self.fetchFavoriteMoviesCalled = true
        }
        
        func unfavoriteMovie(request: ShowFavoriteMovies.UnfavoriteMovie.Request) {
            self.unfavoriteMoviesCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldDoSomethingWhenViewIsLoaded() {
        loadView()
        
        let unfavoriteMovieRequest = ShowFavoriteMovies.UnfavoriteMovie.Request(movie: Movie(id: 1,
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
        let fetchFavoriteMoviesRequest = ShowFavoriteMovies.FetchFavoriteMovies.Request()
        
        sut.interactor?.fetchFavoriteMovies(request: fetchFavoriteMoviesRequest)
        sut.interactor?.unfavoriteMovie(request: unfavoriteMovieRequest)
        
        XCTAssertTrue(spy.unfavoriteMoviesCalled, "unfavoriteMovie() should ask the interactor to do fetch data")
        XCTAssertTrue(spy.fetchFavoriteMoviesCalled, "fetchFavoriteMovies() should ask the interactor to do fetch data")
    }
}
