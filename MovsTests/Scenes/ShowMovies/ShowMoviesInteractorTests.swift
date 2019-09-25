//
//  ShowMoviesInteractorTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 25/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class ShowMoviesInteractorTests: XCTestCase {
  
    // MARK: - Subject under test
    
    var sut: ShowMoviesInteractor!
    var spy: ShowMoviesPresentationLogicSpy?
    
    let expectation = XCTestExpectation(description: "Movie Info Fetched")
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupShowMoviesInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShowMoviesInteractor() {
        sut = ShowMoviesInteractor()
        spy = ShowMoviesPresentationLogicSpy(tester: self)
        sut.presenter = spy
    }
    
    // MARK:  - Test doubles
    
    class ShowMoviesPresentationLogicSpy: ShowMoviesPresentationLogic {
   
        var tester: ShowMoviesInteractorTests?
        
        init(tester: ShowMoviesInteractorTests) {
            self.tester = tester
        }
        
        var presenteMoviesCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        var presentQueriedMoviesCalled: Bool? {
            didSet {
                self.tester?.expectation.fulfill()
            }
        }
        
        func presentMovies(response: ShowMovies.fetchMovies.Response) {
            self.presenteMoviesCalled = true
        }
        
        func presentQueriedMovies(response: ShowMovies.queryMovies.Response) {
            self.presentQueriedMoviesCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testFetchMovieDetails() {
        let fetchMoviesRequest = ShowMovies.fetchMovies.Request(page: 1)
        let fetchQueriedRequest = ShowMovies.queryMovies.Request(keyword: "")
        
        sut.fetchData(request: fetchMoviesRequest)
        sut.queryMovies(request: fetchQueriedRequest)
        
        wait(for: [self.expectation], timeout: 20)
    }
}
