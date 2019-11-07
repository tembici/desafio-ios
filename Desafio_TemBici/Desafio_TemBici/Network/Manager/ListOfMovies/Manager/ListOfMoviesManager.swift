//
//  ListOfMoviesManager.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 06/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

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
    
    var imageURLString: String?
    let imageCache = NSCache<NSString, AnyObject>()
    
    func downloadImageFrom(_ endpoint: String, completed: @escaping(UIImage) -> Void) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(endpoint)")!
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completed(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    if let image = imageToCache {
                        completed(image)
                    }
                }
            }.resume()
        }
    }

}
