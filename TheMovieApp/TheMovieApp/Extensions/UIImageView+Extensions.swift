//
//  UIImageView+Extensions.swift
//  TheMovieApp
//


import UIKit
import Kingfisher

extension UIImageView {
    func loadImageFrom(path:String, withSize size:Int = 300) {
        let stringUrl = "https://image.tmdb.org/t/p/w\(size)\(path)"
        let url = URL(string: stringUrl);
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: size, height: size), mode: .aspectFit);
        self.kf.setImage(with: url,
                         placeholder: UIImage(named: "image_placeholder"),
                         options: [.processor(processor)])
    }
}
