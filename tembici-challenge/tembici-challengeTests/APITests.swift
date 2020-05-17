//
//  APITests.swift
//  tembici-challengeTests
//
//  Created by Hannah  on 17/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import XCTest
@testable import Movs
import Moya

class APITests: XCTestCase {
    
    
    var provider: MoyaProvider<MovieAPI>!
    var networkManager: NetworkManager!
    
    override func setUp() {
      super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
      networkManager = nil
      super.tearDown()
    }
    
    func customEndpointClosure(_ target: MovieAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func customEndpointClosureError(_ target: MovieAPI) -> Endpoint {
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkError(error) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func customEndpointClosureEmptyData(_ target: MovieAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(401, Data()) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func testGetMoviesSuccessReturnsAccommodations() {
        
        let errorExpectation = expectation(description: "fetching movie list from API")
        
        var moviesResponse: [Movie]?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        networkManager.provider = provider
        
        networkManager.getPopularMovies(page: 1) { (result) in
            
            switch result {
            case .success( let moviesResult):
                moviesResponse = moviesResult.moviesList
                errorExpectation.fulfill()
                
            case .failure( _):
                moviesResponse = nil
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (_) in
            XCTAssertNotNil(moviesResponse, "error loading movie list")
        }
    }
    
    func testGetMoviessWhenResponseErrorReturnsError() {
        
        let errorExpectation = expectation(description: "error request Movies from API")
        var errorResponse: String?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosureError, stubClosure: MoyaProvider.immediatelyStub)
        networkManager = NetworkManager()
        networkManager.provider = provider
        
        networkManager.getPopularMovies(page: 1) { (result) in
            
            switch result {
            case .success( _):
                errorResponse = nil
                errorExpectation.fulfill()
                
            case .failure(let error):
                errorResponse = error
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(errorResponse, "unhandled API error")
            
        }
    }
    
    func testGetMoviesWhenEmptyDataReturnsError() {
        
        let errorExpectation = expectation(description: "error empty data from Movies List")
        var errorResponse: String?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosureEmptyData, stubClosure: MoyaProvider.immediatelyStub)
        networkManager = NetworkManager()
        networkManager.provider = provider
        
        networkManager.getPopularMovies(page: 1) { (result) in
            
            switch result {
            case .success( _):
                errorResponse = nil
                errorExpectation.fulfill()
                
            case .failure(let error):
                errorResponse = error
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(errorResponse, "Error Get Movie List from API When return is Empty Data")
            
        }
    }
    
    func testGetGenresSuccessReturnsAccommodations() {
        
        let errorExpectation = expectation(description: "fetching genres list from API")
        
        var genreResponse: [Genre]?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        networkManager.provider = provider
        
        networkManager.getGenres { (result) in
            
            switch result {
            case .success( let moviesResult):
                genreResponse = moviesResult.genres
                errorExpectation.fulfill()
                
            case .failure( _):
                genreResponse = nil
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (_) in
            XCTAssertNotNil(genreResponse, "error loading genres list from API")
        }
    }
    
    func testGetGenresWhenResponseErrorReturnsError() {
        
        let errorExpectation = expectation(description: "error request Genres from API")
        var errorResponse: String?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosureError, stubClosure: MoyaProvider.immediatelyStub)
        networkManager = NetworkManager()
        networkManager.provider = provider
        
        networkManager.getGenres{ (result) in
            
            switch result {
            case .success( _):
                errorResponse = nil
                errorExpectation.fulfill()
                
            case .failure(let error):
                errorResponse = error
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(errorResponse, "unhandled error in API Genre request")
            
        }
    }
    
    func testGetGenresWhenEmptyDataReturnsError() {
        
        let errorExpectation = expectation(description: "error empty data from Genres List")
        var errorResponse: String?
        
        provider = MoyaProvider<MovieAPI>(endpointClosure: customEndpointClosureEmptyData, stubClosure: MoyaProvider.immediatelyStub)
        networkManager = NetworkManager()
        networkManager.provider = provider
        
        networkManager.getGenres { (result) in
            
            switch result {
            case .success( _):
                errorResponse = nil
                errorExpectation.fulfill()
                
            case .failure(let error):
                errorResponse = error
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(errorResponse, "Error Get Genres List from API When return is Empty Data")
            
        }
    }
    
}
