//
//  FavoriteMovieTests.swift
//  Desafio_TemBiciTests
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import XCTest
import CoreData

@testable import Desafio_TemBici

class FavoriteMovieTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    var joker: Movie?

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        
        guard let jokerUrl = bundle.url(forResource: "joker", withExtension: "json") else {
            XCTFail("Missing file: joker.json")
            return
        }
        
        guard let jokerData = try? Data(contentsOf: jokerUrl) else {
            XCTFail("Missing data")
            return
        }
        
        joker = try? JSONDecoder().decode(Movie.self, from: jokerData)
        coreDataManager = CoreDataManager.sharedManager
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_init_coreDataManager(){
        let instance = CoreDataManager.sharedManager
        XCTAssertNotNil( instance )
    }
    
    func test_coreDataStackInitialization() {
      let coreDataStack = CoreDataManager.sharedManager.persistentContainer
      XCTAssertNotNil( coreDataStack )
    }
      
    func test_favorite_a_movie() {
        guard let jokerMovie = joker else { return }
        let joker = coreDataManager.insertMovie(movie: jokerMovie)
        XCTAssertNotNil(joker)
    }
    
    func test_fetch_favorite_movies() {
        guard let jokerMovie = joker else { return }
        let joker = coreDataManager.insertMovie(movie: jokerMovie)
        XCTAssertNotNil(joker)
        
        let results = coreDataManager.fetchMoviesFavorited()
        XCTAssertEqual(results?.count, 1)
    }
    
    func test_remove_movie() {
        guard let jokerMovie = joker else { return }
        let joker = coreDataManager.insertMovie(movie: jokerMovie)
        XCTAssertNotNil(joker)
        
        let favorites = coreDataManager.fetchMoviesFavorited()
        XCTAssert(favorites?.count != 0)
        
        let favorite = favorites![0]
        XCTAssertNotNil(favorite)
        
        coreDataManager.delete(favorite: favorite)
        XCTAssertEqual(coreDataManager.fetchMoviesFavorited()?.count, 0)
    }
    
    func test_remove_movie_by_id() {
        guard let jokerMovie = joker else { return }
        let joker = coreDataManager.insertMovie(movie: jokerMovie)
        XCTAssertNotNil(joker)
        
        let favorites = coreDataManager.fetchMoviesFavorited()
        XCTAssert(favorites?.count != 0)
        
        let favorite = favorites![0]
        XCTAssertNotNil(favorite)
        
        coreDataManager.delete(id: Int(favorite.id))
        XCTAssertEqual(favorites?.count, 0)
    }
    
    func test_get_movie_by_id_exist() {
        guard let jokerMovie = joker else { return }
        let joker = coreDataManager.insertMovie(movie: jokerMovie)
        XCTAssertNotNil(joker)
        
        let exist = coreDataManager.getMovie(id: Int(joker?.id ?? 0))
        XCTAssertEqual(exist, true)
    }
    
    func test_get_movie_by_id_not_exist() {
        guard let jokerMovie = joker else { return }
           
        let exist = coreDataManager.getMovie(id: jokerMovie.id)
        XCTAssertEqual(exist, false)
    }

}
