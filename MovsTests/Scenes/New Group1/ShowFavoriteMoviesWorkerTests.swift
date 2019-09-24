////
////  ShowFavoriteMoviesWorkerTests.swift
////  Movs
////
////  Created by Miguel Pimentel on 24/09/19.
////  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
////

@testable import Movs
import XCTest

class ShowFavoriteMoviesWorkerTests: XCTestCase {
  
    // MARK: Subject under test
    var sut: ShowFavoriteMoviesWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        showFavoriteMoviesWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func showFavoriteMoviesWorker() {
        sut = ShowFavoriteMoviesWorker()
    }
    
    // MARK: Test doubles
    // MARK: Tests
}
