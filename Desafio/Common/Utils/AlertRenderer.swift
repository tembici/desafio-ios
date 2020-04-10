import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AlertRenderderAdapter {
    func showAlert(options: AlertOptions, completion: ((UIAlertAction) -> Void)?)
}

class AlertRenderer: AlertRenderderAdapter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showAlert(options: AlertOptions, completion: ((UIAlertAction) -> Void)?) {
        var alert: UIAlertController!
        
        alert = UIAlertController(
            title: options.title,
            message: options.message,
            preferredStyle: .alert
        )                
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}

struct AlertOptions {
    var title: String?
    var message: String
}
