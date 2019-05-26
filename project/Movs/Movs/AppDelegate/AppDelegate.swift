//
//  AppDelegate.swift
//  Movs
//
//  Created by lordesire on 23/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public var imageCache = NSCache<AnyObject, AnyObject>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.updateTabBarController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    public func updateTabBarController() {
        
        // Assign tab bar item with titles:
        let tabBarController:UITabBarController = self.window?.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar
        //
        tabBar.backgroundImage = App.Utils.Graphic.createFlatImage(size: tabBar.bounds.size, corners: .allCorners, cornerRadius: CGSize.zero, color: App.Style.color1)
        //tabBar.selectionIndicatorImage = App.Utils.Graphic.createFlatImage(size: CGSize.init(width: tabBar.bounds.size.width / 2.0, height: tabBar.bounds.size.height), corners: .allCorners, cornerRadius: CGSize.zero, color: App.Style.color3)
        tabBar.shadowImage = nil
        tabBar.backgroundColor = nil
        tabBar.isTranslucent = false
        tabBar.tintColor = App.Style.color2
        tabBar.unselectedItemTintColor = UIColor.gray
        //
        let tabBarItem1 = tabBar.items?[0]
        let tabBarItem2 = tabBar.items?[1]
        //
        tabBarItem1?.title = "Filmes"
        tabBarItem2?.title = "Favoritos"
        //
        tabBarItem1?.selectedImage = UIImage.init(named: "IconList")?.withRenderingMode(.alwaysTemplate)
        tabBarItem1?.image = UIImage.init(named: "IconList")?.withRenderingMode(.alwaysTemplate)
        
        tabBarItem2?.selectedImage = UIImage.init(named: "IconFavoriteEmpty")?.withRenderingMode(.alwaysTemplate)
        tabBarItem2?.image = UIImage.init(named: "IconFavoriteEmpty")?.withRenderingMode(.alwaysTemplate)
        
        // Change the title color of tab bar items
        //tabBarItem1?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : App.Style.color2, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        //tabBarItem2?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : App.Style.color2, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)], for: .normal)
        //
        //tabBarItem1?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        //tabBarItem2?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)], for: .highlighted)
        
    }
    
}

