//
//  HandlerError.swift
//  MyMovieDB
//
//  Created by Chrytian Salgado Pessoal on 07/06/19.
//  Copyright © 2019 Salgado's Production. All rights reserved.
//

import UIKit

func errorAlert(error: Error) -> UIAlertController {
    let title = Utils.getLocalizedString("ALERT_MENSSAGE_ERROR")
    let alertViewController = Utils.buildAlert(title, mensage: error.localizedDescription, alertButtons: [.DISMISS]) {
        // ...
    }
    
    return alertViewController
}
