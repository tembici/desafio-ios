//
//  SplashViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 17/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class SplashViewControllerBuilder{
    
    static func make(wireframe: SplashWireframe) -> SplashViewController{
        
        let viewController = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
        
        let presenter = SplashPresenterBuilder.make(wireframe: wireframe)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
