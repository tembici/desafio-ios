//
//  Utils.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import Foundation
import UIKit

enum AlertButtonEnum {
    case OK
    case CANCEL
    case DISMISS
}

class Utils {
    
    class func getLocalizedString(_ text: String) -> String {
        return NSLocalizedString(text, comment: "")
    }
    
    class func buildAlert(_ title: String?, mensage: String, alertButtons: [AlertButtonEnum], _ withButtonColor: UIColor? = UIColor.black, completion: @escaping ()-> Void) -> UIAlertController {
        let alertBox = UIAlertController(title: title, message: mensage, preferredStyle: .alert)
        for itens in alertButtons {
            switch itens {
            case .OK:
                let action = UIAlertAction(title: self.getLocalizedString("OK"), style: .default) { (_) in
                    completion()
                }
                alertBox.addAction(action)
            case .CANCEL:
                let action = UIAlertAction(title: self.getLocalizedString("CANCEL"), style: .default) { (_) in }
                alertBox.addAction(action)
            case .DISMISS:
                let action = UIAlertAction(title: self.getLocalizedString("DISMISS"), style: .cancel) { (_) in }
                alertBox.addAction(action)
            }
        }
        return alertBox
    }
}
