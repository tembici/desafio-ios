//
//  PosterImageHelper.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

func getPosterImage(posterPath: String?, quality: ImageQuality = .medium) -> UIImage {
    if let _posterPath = posterPath {
        return "\(imageBaseUrl)/\(quality.rawValue)\(_posterPath)".toImageFromURL() ?? UIImage(named: "banner_default")!
    } else {
        return UIImage(named: "banner_default")!
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
