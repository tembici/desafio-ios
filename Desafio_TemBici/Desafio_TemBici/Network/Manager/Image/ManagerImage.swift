//
//  ManagerImage.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

class ManagerImage {
 
    static var shared = ManagerImage()
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
