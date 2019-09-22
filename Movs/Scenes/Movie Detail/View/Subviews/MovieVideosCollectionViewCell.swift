//
//  MovieVideosCollectionViewCell.swift
//  Movs
//
//  Created by Miguel Pimentel on 21/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit
import WebKit

class MovieVideosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoWebView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLayout()
    }
    
    func setup(with content: Any) {
        if let video = content as? Video {
            guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(video.key)")
                else { return }
            let request = URLRequest(url: youtubeURL)
            
            videoWebView.load(request)
        }
    }
    
    private func setupLayout() {
        self.videoWebView.layer.cornerRadius = 15
        self.videoWebView.layer.masksToBounds = true
    }

}
