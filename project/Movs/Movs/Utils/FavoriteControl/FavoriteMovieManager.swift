//
//  FavoriteMovieManager.swift
//  Movs
//
//  Created by lordesire on 25/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

class FavoriteMovieManager:NSObject{
    
    class func saveFavorite(movieID:Int) {
        
        var favoriteSet:Array<Int>? = UserDefaults.standard.value(forKey: "FavoriteMovies") as? Array<Int>
        
        if (favoriteSet != nil){
            
            //Update
            if (!favoriteSet!.contains(movieID)){
                favoriteSet!.append(movieID)
                //
                UserDefaults.standard.setValue(favoriteSet!, forKey: "FavoriteMovies")
                UserDefaults.standard.synchronize()
                //
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoriteDidChange"), object: movieID)
                }
            }
            
        }else{
            
            //Create
            favoriteSet = Array.init()
            favoriteSet!.append(movieID)
            //
            UserDefaults.standard.setValue(favoriteSet!, forKey: "FavoriteMovies")
            UserDefaults.standard.synchronize()
            //
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoriteDidChange"), object: movieID)
            }
        }
        
    }
    
    class func removeFavorite(movieID:Int) {
        
        var favoriteSet:Array<Int>? = UserDefaults.standard.value(forKey: "FavoriteMovies") as? Array<Int>
        
        if (favoriteSet != nil){
            
            //Delete
            if (favoriteSet!.contains(movieID)){
                favoriteSet!.remove(at: favoriteSet!.index(of: movieID)!)
                //
                UserDefaults.standard.setValue(favoriteSet!, forKey: "FavoriteMovies")
                UserDefaults.standard.synchronize()
                //
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoriteDidChange"), object: movieID)
                }
            }
        }
        
    }
    
    class func checkFavorite(movieID:Int) -> Bool {
        
        let favoriteSet:Array<Int>? = UserDefaults.standard.value(forKey: "FavoriteMovies") as? Array<Int>
        if (favoriteSet != nil){
            //Select
            if (favoriteSet!.contains(movieID)){
                return true
            }
        }
        return false
    }
    
    class func allFavorites() -> Array<Int> {
        
        let favoriteSet:Array<Int>? = UserDefaults.standard.value(forKey: "FavoriteMovies") as? Array<Int>
        if (favoriteSet != nil){
            return favoriteSet!
        }else{
            return Array<Int>.init()
        }
        
    }
    
}
