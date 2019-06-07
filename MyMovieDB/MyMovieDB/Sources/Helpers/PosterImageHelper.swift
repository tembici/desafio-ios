//
//  PosterImageHelper.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

func getPosterImage(posterPath: String?) -> UIImage {
    if let _posterPath = posterPath {
        return UIImage(contentsOfFile: "\(imageBaseUrl)\(_posterPath)") ?? UIImage(named: "banner_default")!
    } else {
        return UIImage(named: "banner_default")!
    }
}
