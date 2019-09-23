//
//  MovieDetailViewControllerTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class MovieDetailViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: MovieDetailViewController!
    let spy = MovieDetailBusinessLogicSpy()
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMovieDetailViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupMovieDetailViewController() {
        sut =  MovieDetailViewController()
        sut.interactor = spy
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class MovieDetailBusinessLogicSpy: MovieDetailBusinessLogic {
        
        var fetchMovieDetailsCalled = false
        var fetchMovieVideoCalled = false
        
        
        func fetchMovieDetails(request: MovieDetail.FetchMovieDetails.Request) {
            self.fetchMovieDetailsCalled = true
        }
        
        func fetchMovieVideos(request: MovieDetail.FetchMovieVideos.Request) {
            self.fetchMovieVideoCalled = true
        }
    }
    
    // MARK: Tests
    func testShouldDoSomethingWhenViewIsLoaded() {
        loadView()
        
        XCTAssertTrue(spy.fetchMovieDetailsCalled, "fetchMovieVideos() should ask the interactor to do fetch data")
        XCTAssertTrue(spy.fetchMovieDetailsCalled, "fetchMovieDetails() should ask the interactor to do fetch data")
    }
}
