//
//  MovieDetailsWireframe.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 19/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsWireframe{
    
    var navigationController: UINavigationController?
    
    func present(navigationController: UINavigationController, movie: MovieEntity){
        
        self.navigationController = navigationController
        self.navigationController?.pushViewController(MovieDetailsViewControllerBuilder.make(wireframe: self, movie: movie), animated: true
        )
    }
}
