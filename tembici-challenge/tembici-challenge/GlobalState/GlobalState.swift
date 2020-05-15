//
//  GlobalState.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var genres = [Genre]()
    var isLoading = false
    
    func fetchGenres(){
        if (isLoading){
            return
        }
        isLoading = true
        
        let provider = NetworkManager()
        
        if(self.genres.isEmpty){
            provider.getGenres { (result) in
                self.isLoading = false
                switch result {
                case .success(let genresList):
                    self.genres = genresList.genres
                case .failure(let error):
                    print(error)
                }
                
            }
        }
    }
}
