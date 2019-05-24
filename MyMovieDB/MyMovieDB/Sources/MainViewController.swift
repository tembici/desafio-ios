//
//  MainViewController.swift
//  MyMovieDB
//
//  Created by Chrystian Salgado on 24/05/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    private func configureUI() {
        self.title = NSLocalizedString("MOVIES_TITLE", comment: "")
    }

}

