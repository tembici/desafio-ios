//
//  DetailMovieManager.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import Foundation

protocol DetailMovieManagerDelegate: class {
    func success(detailOfMovie: DetailOfMovie)
    func error(message: String)
}

class DetailMovieManager: NSObject {
    
    let router = Router<MoviesEndpoint>()
    weak var delegate: DetailMovieManagerDelegate?
    
    init(delegate: DetailMovieManagerDelegate) {
        self.delegate = delegate
    }
    
    func getDetailOfMovie(id: Int) {
        router.request(.detail(id: id)) { (data, response, error) in
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
                    
                    guard let resp = try? JSONDecoder().decode(DetailOfMovie.self, from: data) else {
                        self.delegate?.error(message: ErrorResp.generic)
                        return
                    }
                    
                    self.delegate?.success(detailOfMovie: resp)
                    
                default:
                    self.delegate?.error(message: ErrorResp.generic)
                }
            }
        }
    }

}
