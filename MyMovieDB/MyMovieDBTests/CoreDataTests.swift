//
//  MyMovieDBTests.swift
//  MyMovieDBTests
//
//  Created by Chrystian Salgado on 10/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import XCTest
@testable import MyMovieDB

class CoreDataTests: XCTestCase {
    
    var movie: MovieResult!

    override func setUp() {
        movie = MovieResult(id: 200,
                                title: "Teste",
                                originalTitle: "Teste",
                                posterPath: nil,
                                video: nil,
                                originalLanguage: nil,
                                backdropPath: nil,
                                adult: nil,
                                overview: nil,
                                releaseDate: nil, genres: nil,
                                favorite: true)
    }

    override func tearDown() {
        do {
            try CoreDataHelper().deleteAllData(in: Entitys.Movie)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testSaveSingle() {
        do {
            let success = try CoreDataHelper().save(in: Entitys.Movie, value: "Some", forKey: "title")
            XCTAssertTrue(success)
        } catch {
            XCTFail("Can not save data in this entity")
        }
    }

    func testSavingWithConfirmation() {
        do {
            try CoreDataController().saveOrUpdate(movie: movie)
            if let itens = try CoreDataHelper().getData(in: Entitys.Movie) {
                for iten in itens {
                    if iten.value(forKey: "id") as? Int == movie.id {
                        XCTAssertTrue(iten.value(forKey: "title") as? String == movie.title)
                        return
                    } else {
                        XCTFail("Could not find movie")
                    }
                }
            } else {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func testSaveMovie() {
        if let movieManagedObject = movie.toNSManagedObject() {
            do {
                let success = try CoreDataHelper().saveSingleObject(object: movieManagedObject)
                XCTAssertTrue(success)
            } catch {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
    func testSaveAndDelete() {
        if let movieManagedObject = movie.toNSManagedObject() {
            do {
                let _ = try CoreDataHelper().saveSingleObject(object: movieManagedObject)
                let success = try CoreDataHelper().deleteData(object: movieManagedObject, in: Entitys.Movie)
                XCTAssertTrue(success)
            } catch {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
    func testGetData() {
        XCTAssertTrue(CoreDataHelper().getObject(in: Entitys.Movie) != nil)
    }
    
    func testDeleteAll() {
        do {
            if let movies = try CoreDataHelper().getData(in: Entitys.Movie) {
                for movie in movies {
                    XCTAssertTrue(try CoreDataHelper().deleteData(object: movie, in: Entitys.Movie))
                }
            }
        } catch {
            XCTFail("Could not retrive data from this entity")
        }
    }
    
    private func removeAll() {
        
    }
}
