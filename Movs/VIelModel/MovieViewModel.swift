//
//  MovieViewModel.swift
//  Movs
//
//  Created by Ivan Ortiz on 15/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation

protocol MovieViewModelDelegate {
    func didGetMoviesList(movies:[Movie]?, error:Bool, errorType:String?)
    func didGetGenreList(genres:[Genre]?, error:Bool, errorType:String?)
    
}

class MovieViewModel: NSObject {
    var delegate:MovieViewModelDelegate?
    func getMoviesList(page:Int)
    {
        HttpClient.shared.getMoviesList(page:page) { (data, err) in
            if err != nil
            {
                self.delegate?.didGetMoviesList(movies:nil, error:true, errorType:"")
            }
            else
            {
                self.delegate?.didGetMoviesList(movies:data?.results, error:false, errorType:nil)
            }
        }
    }
    
    func getGenreList()
    {
        HttpClient.shared.getGenreList() { (data, err) in
            if err != nil
            {
                self.delegate?.didGetGenreList(genres:nil, error:true, errorType:"")
            }
            else
            {
                self.delegate?.didGetGenreList(genres:data?.genres, error:false, errorType:nil)
            }
        }
    }
}
