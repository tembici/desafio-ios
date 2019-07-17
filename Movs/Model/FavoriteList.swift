//
//  FavoriteList.swift
//  Movs
//
//  Created by Ivan Ortiz on 16/07/19.
//  Copyright © 2019 Ivan Ortiz. All rights reserved.
//

import Foundation
class FavoriteList {
    static var shared = FavoriteList()
    private init() { loadMovies() }
    var list = [Movie]()
    
    func favoriteHandler(with movie:Movie) {
        
        if let index = list.firstIndex(where: { $0.id == movie.id }) {
            list.remove(at: index)
        }
        else
        {
            list.append(movie)
        }
        saveList()
    }
    
    func saveList() {
        do {
            let moviesData = try NSKeyedArchiver.archivedData(withRootObject: list, requiringSecureCoding: false)
            UserDefaults.standard.set(moviesData, forKey: "movies")
            print("List successfully saved...")
        } catch {
            print("Failed to save list...")
        }
    }
    
    func loadMovies(){
        let moviesData = UserDefaults.standard.object(forKey: "movies") as? NSData
        if moviesData != nil
        {
            do {
                let data = Data(referencing:moviesData!)
                if let loadMovies = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Movie> {
                    list = loadMovies
                }
            } catch {
                print("Failed to load list...")
            }
        }
    }
}
