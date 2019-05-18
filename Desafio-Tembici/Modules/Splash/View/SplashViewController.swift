//
//  SplashViewController.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 17/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool{ return true}
    
    var presenter: SplashPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
}
