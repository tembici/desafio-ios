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
    
    func placeInWindow(window: UIWindow){
        
        let viewController = SplashViewControllerBuilder.make(wireframe: self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presentTab(){
        
    }
}
