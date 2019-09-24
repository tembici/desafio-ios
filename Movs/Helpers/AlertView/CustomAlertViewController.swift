//
//  CustomAlertViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    // MARK: - Constructor
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    convenience init() {
        self.init()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
}
