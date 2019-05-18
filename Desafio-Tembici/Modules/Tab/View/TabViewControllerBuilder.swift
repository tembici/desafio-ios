//
//  TabViewControllerBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 18/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class TabViewControllerBuilder{
    
    static func make() -> TabViewController{
        
        let tabViewController = TabViewController()
        tabViewController.viewControllers = []
        
        return tabViewController
    }
}
