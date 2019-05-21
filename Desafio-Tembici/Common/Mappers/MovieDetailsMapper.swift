//
//  MovieDetailsMapper.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 20/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsMapper{
    
    static func make(from details: MovieEntity) -> MovieDetailsItem?{
        
        guard let title = details.title,
              let posterImage = details.thumb,
              let sinopse = details.sinopse,
              let releaseYear = details.releaseDate?.prefix(4) else{ return nil}
        
        let vpurl = VPURL(urlString: "https://image.tmdb.org/t/p/w1280/"+posterImage)
        
        var data: Data?
        
        do{
            let url = try vpurl.asURL()
            data = NSData(contentsOf: url) as Data?
        }catch{}
        
        
        return MovieDetailsItem(title: title, posterImage: data!, sinopse: sinopse, releaseYear: String(releaseYear), favorite: details.favorite)
    }
    
    static func make(from details: MovieDetailsItem) -> MovieDetailsDisplay?{
        
        guard let title = details.title,
            let posterImage = details.posterImage,
            let sinopse = details.sinopse,
            let releaseYear = details.releaseYear,
            let favorite = details.favorite else{ return nil}
        
        let image = UIImage(data: posterImage)
        
        return MovieDetailsDisplay(title: title, posterImage: image!, sinopse: sinopse, releaseYear: releaseYear, favorite: favorite)
    }
}
