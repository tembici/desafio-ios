//
//  MovsAPITests.swift
//  MovsTests
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import XCTest
import CoreData
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
    
    func testMovieDetailsFound() {
        let e = expectation(description: "MoviesServices - testMovieDetailsFound")
        
        movieAPI.details(movie: "645541") { (result, error) in
            XCTAssertNotNil(result!, "Expected non-nil data")
            XCTAssertTrue(!(result!.isEmpty))
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testMovieDetailsNotFound() {
        let e = expectation(description: "MoviesServices - testMovieDetailsNotFound")
        
        movieAPI.details(movie: "0") { (result, error) in
            XCTAssertNil(result, "Expected nil data")
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testMoviesSearch() {
        let e = expectation(description: "MoviesServices - testMoviesSearch")
        
        movieAPI.search(query: "Lord of", page: 1) { (result, error) in
            XCTAssertNotNil(result!, "Expected non-nil data")
            XCTAssertTrue(!(result!.isEmpty))
            e.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFavoritesDataBase() {
        let e = expectation(description: "MoviesServices - textFavoritesDataBase")
        
        let result: [Favorites] = CoreDataServices.shared.getAllFavorites()
        
        XCTAssertTrue(result.count > 0)
        e.fulfill()
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
