//
//  MovieDetailInteractorTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class MovieDetailInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: MovieDetailInteractor!
    var spy: MovieDetailPresentationLogicSpy?
    
    let expectation = XCTestExpectation(description: "Movie Info Fetched")
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMovieDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupMovieDetailInteractor() {
        sut = MovieDetailInteractor()
        spy = MovieDetailPresentationLogicSpy(tester: self)
        sut.presenter = spy
    }
    
    // MARK: Test doubles
    class MovieDetailPresentationLogicSpy: MovieDetailPresentationLogic {
        
        var presentMovieDetailsCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        var presentMovieVideosCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        var tester: MovieDetailInteractorTests?
        
        init(tester: MovieDetailInteractorTests) {
            self.tester = tester
        }
        
        func presentMovieDetails(response: MovieDetail.FetchMovieDetails.Response) {
            self.presentMovieDetailsCalled = true
        }
        
        func presentMovieVideos(response: MovieDetail.FetchMovieVideos.Response) {
            self.presentMovieVideosCalled = true
        }
    }
    
    // MARK: Tests
    func testFetchMovieDetails() {
        let movieVideoRequest = MovieDetail.FetchMovieVideos.Request(movieId: 20)
        let movieDetailRequest = MovieDetail.FetchMovieDetails.Request(movieId: 20)
        
        sut.fetchMovieDetails(request: movieDetailRequest)
        sut.fetchMovieVideos(request: movieVideoRequest)
        
        wait(for: [self.expectation], timeout: 20)
        
    }
}
