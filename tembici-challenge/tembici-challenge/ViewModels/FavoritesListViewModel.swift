//
//  FavoritesListViewModel.swift
//  tembici-challenge
//
//  Created by Hannah  on 16/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation


class FavoritesListViewModel: ObservableObject {
    @Published var favoriteList = [Movie]()
    @Published   var searchNotFound = false
    @Published var searchText: String = "" {
        didSet {
            self.search()
        }
    }
    var globalState: GlobalState
    
    init(globalState: GlobalState) {
        self.globalState = globalState
        favoriteList = self.globalState.favorites
        
    }
    func deleteFavorite(at offsets: IndexSet) {
        let movie = favoriteList[offsets.first!]
        favoriteList.remove(atOffsets: offsets)
        globalState.addFavorite(movie: movie)
    }
    func search (){
        favoriteList = globalState.favorites.filter {
            searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased())}
        
        if (favoriteList.count == 0){
            searchNotFound = true
        }else{
            searchNotFound = false
        }
    }
}
