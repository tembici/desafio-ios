//
//  ListOfMoviesManager.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import Foundation

protocol ListOfMoviesManagerDelegate: class {
    func success(listOfMovies: ListOfMovies)
    func error(message: String)
}

class ListOfMoviesManager: NSObject {
    
    let router = Router<MoviesEndpoint>()
    weak var delegate: ListOfMoviesManagerDelegate?
    
    init(delegate: ListOfMoviesManagerDelegate) {
        self.delegate = delegate
    }
    
    func getPopularMovies(page: Int) {
        router.request(.popular(page: page)) { (data, response, error) in
            if error != nil {
                self.delegate?.error(message: ErrorResp.generic)
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    guard let data = data else {
                        self.delegate?.error(message: ErrorResp.generic)
                        return
                    }
                    
                    guard let resp = try? JSONDecoder().decode(ListOfMovies.self, from: data) else {
                        self.delegate?.error(message: ErrorResp.generic)
                        return
                    }
                    
                    self.delegate?.success(listOfMovies: resp)
                    
                default:
                    self.delegate?.error(message: ErrorResp.generic)
                }
            }
        }
    }

}
