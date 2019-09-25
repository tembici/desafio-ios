//
//  ShowMoviesViewControllerTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 25/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class ShowMoviesViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    
    var sut: ShowMoviesViewController!
    let spy = ShowMoviesBusinessLogicSpy()
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
        sut =  ShowMoviesViewController()
        sut.interactor = spy
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class ShowMoviesBusinessLogicSpy: ShowMoviesBusinessLogic {
        
        var queryMoviesCalled = false
        var fetchMoviesCalled = false
        var setAsFavoriteCalled = false
        
        func fetchData(request: ShowMovies.fetchMovies.Request) {
            self.fetchMoviesCalled = true
        }
        
        func setAsFavorite(request: ShowMovies.favoriteMovie.Request) {
            self.setAsFavoriteCalled = true
        }
        
        func queryMovies(request: ShowMovies.queryMovies.Request) {
            self.queryMoviesCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldDoSomethingWhenViewIsLoaded() {
        loadView()
        
        let fetchDataRequest = ShowMovies.fetchMovies.Request(page: 1)
        let queryMoviesRequest = ShowMovies.queryMovies.Request(keyword: "")
        let setFavoriteRequest = ShowMovies.favoriteMovie.Request(movie: Movie(id: 1,
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
       
    
        sut?.interactor?.setAsFavorite(request: setFavoriteRequest)
        sut?.interactor?.fetchData(request: fetchDataRequest)
        sut?.interactor?.queryMovies(request: queryMoviesRequest)
        
        XCTAssertTrue(spy.setAsFavoriteCalled, "setAsFavoriteMovie() should ask the interactor to do fetch data")
        XCTAssertTrue(spy.queryMoviesCalled, "queryMovie() should ask the interactor to do fetch data")
        XCTAssertTrue(spy.fetchMoviesCalled, "fetchData() should ask the interactor to do fetch data")
    }
}
