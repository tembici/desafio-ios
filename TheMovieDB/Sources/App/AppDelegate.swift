//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        UITabBar.appearance().barTintColor = Color.yellow
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let coredataWorker = MovieCoreDataWorker()
        let movies = try! coredataWorker.fetch(favorited: false)
        movies.filter({ !$0.favorited }).forEach { (movie) in
            try! coredataWorker.delete(movie)
        }
    }
    
}
