import UIKit

public extension UIApplication {
    
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 3848
            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBar.tag = tag
                if !isStatusBarHidden {
                    keyWindow?.addSubview(statusBar)
                }
                return statusBar
            }
        } else {
            return value(forKey: "statusBar") as? UIView
        }
    }
}
