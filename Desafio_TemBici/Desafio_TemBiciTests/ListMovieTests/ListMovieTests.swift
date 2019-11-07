//
//  ListMovieTests.swift
//  Desafio_TemBiciTests
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import XCTest

@testable import Desafio_TemBici

class ListMovieTests: XCTestCase {

    var list: ListOfMovies?

    override func setUp() {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "list", withExtension: "json") else {
            XCTFail("Missing file: list.json")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Missing data")
            return
        }
        
        list = try? JSONDecoder().decode(ListOfMovies.self, from: data)
    }
    
    override func tearDown() {
         list = nil
     }

    func test_MissingResponse() {
        list = nil
        XCTAssert(list == nil)
    }
    
    func test_ListExist() {
        guard let list = list else { XCTFail("Missing list"); return }
        XCTAssert(list.results.count != 0)
    }
    
    func test_ListContainJoker() {
        guard let list = list else { XCTFail("Missing list"); return }
        XCTAssert(list.results.contains(where: { (movie) -> Bool in
            if movie.title == "Joker" {
                return true
            }
            return false
        }))
    }

}
