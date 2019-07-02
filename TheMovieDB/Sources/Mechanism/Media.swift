//
//  Media.swift
//  Galaxy
//
//  Created by Marcos Kobuchi on 03/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import UIKit.UIImage
import UIKit.UIImageView

class Media {
    
    private static var associated: [UIImageView: String] = [:]
    private static var lock: NSLock = NSLock()
    
    static func download(path: String, imageView: UIImageView) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            self.lock.lock()
            self.associated[imageView] = path
            self.lock.unlock()
            
            var image: UIImage?
            do {
                let data: Data = try API.download(request: Request.get(domain: "http://image.tmdb.org/t/p/w185", endpoint: path, cache: true))
                image = UIImage(data: data)
            } catch {
            }
            
            self.lock.lock()
            if self.associated[imageView] == path {
                self.associated[imageView] = nil
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.alpha = 0.0
                    UIView.animate(withDuration: 0.5, animations: {
                        imageView.alpha = 1.0
                    })
                }
            }
            self.lock.unlock()
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}
