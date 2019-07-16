//
//  UIImage+Movs.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromUrl(_ URLString: String, placeHolder: UIImage?) {
        
        if placeHolder != nil
        {
            self.image = placeHolder
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        let urlString = "https://image.tmdb.org/t/p/w500" + URLString
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

