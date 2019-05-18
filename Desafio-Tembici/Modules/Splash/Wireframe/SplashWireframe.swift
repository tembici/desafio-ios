//
//  SplashWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 17/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class SplashWireframe{
    
    var window: UIWindow?
    
    func placeInWindow(window: UIWindow){
        
        self.window = window
        
        let viewController = SplashViewControllerBuilder.make(wireframe: self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presentTab(){
        
        guard let window = self.window else{
            return
        }
        TabWireframe().present(window: window)
    }
}
