//
//  MovieDetailWorkerTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.

@testable import Movs
import XCTest

class MovieDetailWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: MovieDetailWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMovieDetailWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupMovieDetailWorker() {
        sut = MovieDetailWorker()
    }
    
    // MARK: Test doubles
    // MARK: Tests
}
