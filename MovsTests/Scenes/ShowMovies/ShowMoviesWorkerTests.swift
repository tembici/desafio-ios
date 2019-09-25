//
//  ShowMoviesWorkerTests.swift
//  Movs
//
//  Created by Miguel Pimentel on 25/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

@testable import Movs
import XCTest

class ShowMoviesWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: ShowMoviesWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        showMoviesWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func showMoviesWorker() {
        sut = ShowMoviesWorker()
    }
    
    // MARK: Test doubles
    // MARK: Tests
}
