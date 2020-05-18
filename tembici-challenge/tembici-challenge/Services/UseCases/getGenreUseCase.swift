//
//  getGenreUseCase.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

enum  GetGenresResult {
    case success(Genres)
    case failure(String)
}


typealias GetGenreCompletion = (GetGenresResult) -> Void


extension NetworkManager {
    
    
    func getGenres( completion: @escaping (GetGenreCompletion)){
        
        if Connectivity.isConnectedToInternet {
            provider.request(.genre) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode(Genres.self, from: response.data)
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
        } else{
            completion(.failure("Please check your network connection."))
        }
    }
}
