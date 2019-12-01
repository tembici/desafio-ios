//
//  MovsAPITests.swift
//  MovsTests
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import XCTest
@testable import Movs

class MovsAPITests: XCTestCase {
    
    let movieAPI = MoviesServices()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPopularMovies() {
        let e = expectation(description: "MoviesServices - testGetPopularMovies")
        
        movieAPI.popular { (result, error) in
            XCTAssertNotNil(result!, "Expected non-nil data")
            XCTAssertTrue(!(result!.isEmpty))
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
