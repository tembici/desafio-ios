//
//  FavoriteMoviesDAO.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class FavoriteMoviesDAO{
    
    public static var shared = FavoriteMoviesDAO()
    
    var favoriteMoviesList: [Int] = []

    fileprivate static let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    static var favoritesURL: URL {
        return URL(fileURLWithPath: dir.appendingPathComponent("favorites.json"))
    }
    
    private init(){
        
    }
    
    func save(_ movieIds: [Int]){
        
        let url = FavoriteMoviesDAO.favoritesURL
        
        do {
            try JSONEncoder().encode(movieIds).write(to: url)
            self.favoriteMoviesList = movieIds
            print("Save in", String(describing: url))
        } catch {
            print("It could not save", String(describing: url))
        }
    }
    
    func save(_ movieId: Int){
        
        self.favoriteMoviesList.append(movieId)
        self.save(self.favoriteMoviesList)
    }
    
    func getFavoriteMovieIds() -> [Int]{
        
        let url = FavoriteMoviesDAO.favoritesURL
        do {
            let readedData = try Data(contentsOf: url)
            let ids = try JSONDecoder().decode([Int].self, from: readedData)
            return ids
        } catch {
            print("It could not read from", String(describing: url))
        }
        return []
    }
}
