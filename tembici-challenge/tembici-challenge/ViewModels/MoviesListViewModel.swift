//
//  MoviesListViewModel.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    
    @Published var moviesList = [[Movie]]()
    @Published var isLoading = false
    @Published var showMsgError = false
    @Published var loadingMore = false
    @Published   var searchNotFound = false
    @Published var searchText: String = "" {
           didSet {
               self.search()
           }
    }
    
    let provider = NetworkManager()
    var totalPages = 0
    var page: Int = 1
    var movies = [Movie]()
    
    
    // MARK: - Methods
    /// load date from api
    func fetchMovies() {
        
        if (isLoading){
            return
        }
        
        if(totalPages>0 && movies.count == totalPages){
            return
        }
        isLoading = true
        provider.getPopularMovies(page: page) { result in
            self.isLoading = false
            
            switch result {
            case .success(let moviesResult):
                self.showMsgError = false
                self.page += 1
                self.totalPages = moviesResult.totalPages
                self.movies.append(contentsOf: moviesResult.moviesList)
                self.moviesList = self.movies.chunked(into: 2)
            case .failure(let error):
                self.showMsgError = true
                print(error)
                return
            }
        }
    }
    
    func fetchLoadMore(row: Int) {
        if (row == self.moviesList.count-1 && searchText.isEmpty){
            self.fetchMovies()
            loadingMore = true
        }else{
            loadingMore = false
        }
    }
    
    func search (){
        
        moviesList = self.movies.filter {
        searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased())}.chunked(into: 2)
           
           if (moviesList.count == 0){
               searchNotFound = true
           }else{
               searchNotFound = false
           }
       }
}
