//
//  FavoritesWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 21/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class FavoritesWireframe{
    
    func getViewController() -> FavoritesViewController{
        
        return FavoritesViewControllerBuilder.make(wireframe: self)
    }
}
