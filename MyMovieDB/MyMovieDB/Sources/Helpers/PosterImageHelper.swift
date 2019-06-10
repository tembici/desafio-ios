//
//  PosterImageHelper.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit
import Kingfisher

let imageBaseUrl = "https://image.tmdb.org/t/p/"

enum ImageQuality: String {
    case low = "w185"
    case medium = "w342"
    case high = "w500"
}

func imageHelper(posterPath: String?, quality: ImageQuality = .medium) -> UIImage {
    if let _posterPath = posterPath {
        return "\(imageBaseUrl)/\(quality.rawValue)\(_posterPath)".toImageFromURL() ?? UIImage(named: "banner_default")!
    } else {
        return UIImage(named: "banner_default")!
    }
}

func imageHelper(oldImageView: UIImageView, posterPath: String?, quality: ImageQuality = .medium) -> UIImageView {
    let imageView = oldImageView
    
    if let _posterPath = posterPath {
        let stringUrl = "\(imageBaseUrl)/\(quality.rawValue)\(_posterPath)"
        let url = URL(string: stringUrl)
        let processor = DownsamplingImageProcessor(size: imageView.image?.size ?? CGSize(width: 0, height: 0))
            >> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "banner_default"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return imageView
    } else {
        imageView.image = UIImage(named: "banner_default")
        return imageView
    }
}

private extension String {
    
    func toImageFromURL() -> UIImage? {
        if let url = URL(string: self) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch {
                return nil
            }
        }
        else {
            return nil
        }
    }
}
