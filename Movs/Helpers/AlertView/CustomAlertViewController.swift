//
//  CustomAlertViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 24/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate: class {
    func didSelectCancel()
    func didSelectConfirm()
}

class CustomAlertViewController: UIViewController {
    
    // MARK: - Delegate
    
    var delegate: CustomAlertViewDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var alertMessageLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.delegate?.didSelectConfirm()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.delegate?.didSelectCancel()
    }
   
    // MARK: - Constructor
    
    convenience init(delegate: CustomAlertViewDelegate) {
        self.init()
        self.delegate = delegate
        self.setupLayout()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
}
