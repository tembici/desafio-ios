//
//  NetworkManager.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

final class NetworkManager: ProviderProtocol {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: Endpoint, completion: @escaping (Result<T, NetworkError>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data,
                                     response: httpResponse,
                                     error: error,
                                     completion: completion)
        })
        task.resume()
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?,
                                                  error: Error?, completion: (Result<T, NetworkError>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        switch response.statusCode {
            case 200...299:
                guard let data = data,
                    let model = try? JSONDecoder().decode(T.self, from: data)
                    else { return completion(.failure(.parserError)) }
                completion(.success(model))
            default:
                completion(.failure(.unknown))
        }
    }
}

