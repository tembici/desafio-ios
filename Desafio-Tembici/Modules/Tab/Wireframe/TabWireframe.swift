//
//  TabWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class TabWireframe{
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func present(window: UIWindow){
        
        self.window = window
        
        let viewController = UITabBarController()
        setUpRoot(viewController)
    }
    
    private func setUpRoot(_ viewController: UIViewController){
        
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
    }
}
