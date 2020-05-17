//
//  MovieApi+Tests.swift
//  tembici-challengeTests
//
//  Created by Hannah  on 17/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//



import Foundation
@testable import Movs

extension MovieAPI {
    
    var testSampleData: Data {
        var dataUrl: URL?
        
        switch self {
        case .popular(page: _):
            dataUrl = Bundle(for: APITests.self).url(forResource: "Movies", withExtension: "json")
            if let url = dataUrl, let data = try? Data(contentsOf: url) {
                debugPrint(data)
                return data
            }
        case .genre:
            dataUrl = Bundle(for: APITests.self).url(forResource: "Genres", withExtension: "json")
            if let url = dataUrl, let data = try? Data(contentsOf: url) {
                debugPrint(data)
                return data
            }
            
        }
        return Data()
    }
}
