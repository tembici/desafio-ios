//
//  getPopularMoviesUseCase.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation
import Network
enum  GetPopularMoviesResult {
    case success(Movies)
    case failure(String)
}


typealias GetPopularMoviesCompletion = (GetPopularMoviesResult) -> Void


extension NetworkManager {
    
    
    func getPopularMovies(page: Int, completion: @escaping (GetPopularMoviesResult)->()){
        
        if Connectivity.isConnectedToInternet {
            provider.request(.popular(page: page)) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode(Movies.self, from:
                            response.data)
                    
                        completion(.success(results))
                    } catch let error {
                        completion(.failure(error.localizedDescription))
                        print(error)
                    }
                case let .failure(error):
                    completion(.failure(error.localizedDescription))
                    print(error)
                }
            }
        }else{
            completion(.failure("Please check your network connection."))
        }
        
    }
}
