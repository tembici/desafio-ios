import UIKit

extension UIView {
    
    var currentFirstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let currentFirstResponder = subview.currentFirstResponder {
                return currentFirstResponder
            }
        }
        return nil
    }
	
}
