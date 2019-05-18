//
//  AppDelegate.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 17/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
//        let api = MoviesAPI()
//        api.getMovies(completion: { (movies) in
//
//            for movie in movies{
//                print(movie.title!+" id: \(movie.id)")
//            }
//            })
        
        guard let window = self.window else{
            return false
        }
        SplashWireframe().placeInWindow(window: window)
        return true
    }
}

