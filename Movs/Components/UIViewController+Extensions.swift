//
//  UIViewController+Extensions.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
