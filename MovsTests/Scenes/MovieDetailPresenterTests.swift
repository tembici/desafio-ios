//
//  MovieDetailPresenterTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class MovieDetailPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    
    var sut: MovieDetailPresenter!
    let spy: MovieDetailDisplayLogicSpy = MovieDetailDisplayLogicSpy()
    
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
        sut = MovieDetailPresenter()
        sut.viewController = spy
    }
    
    // MARK: Test
    
    class MovieDetailDisplayLogicSpy: MovieDetailDisplayLogic {
        
        var displayVideosCalled = false
        var displayMoviesCalled = false
        
        func displayVideos(viewModel: MovieDetail.FetchMovieVideos.ViewModel) {
            self.displayVideosCalled = true
        }
        
        func displayMovieDetails(viewModel: MovieDetail.FetchMovieDetails.ViewModel) {
            self.displayMoviesCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentMovieDetail() {
        
        let videosResponse = MovieDetail.FetchMovieVideos.Response(content: [Any]())
        let movieDetailResponse = MovieDetail.FetchMovieDetails.Response(movie: Movie(id: 10,
                                                                                      imageUrl: "",
                                                                                      posterImageUrl: "",
                                                                                      title: "",
                                                                                      overview: "",
                                                                                      release: "",
                                                                                      rate: 0.0,
                                                                                      genres: [Int](),
                                                                                      language: "",
                                                                                      movieLength: 10,
                                                                                      isFavorite: .favorite,
                                                                                      category: .topRated))
        
        sut.presentMovieDetails(response: movieDetailResponse)
        sut.presentMovieVideos(response: videosResponse)
        
        XCTAssertTrue(spy.displayMoviesCalled, "displayMovieDetails(response:) should ask the view controller to display the result")
        XCTAssertTrue(spy.displayVideosCalled, "displayVideos(response:) should ask the view controller to display the result")
    }
}
