//
//  NetworkManager.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation
import Moya

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

protocol NetworkManagerProtocol {
    
//    func getGenres( completion: @escaping (GetGenreCompletion)->())
    func getPopularMovies(page: Int, with completion: @escaping (GetPopularMoviesCompletion))
}

struct NetworkManager: Network {
    var provider = MoyaProvider<MovieAPI>()
}
