import UIKit

public extension UINavigationController {
    func push(_ viewController: UIViewController,
              transitionType type: String = CATransitionType.fade.rawValue,
              duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(viewController, animated: false)
    }
    
    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
    
    func pop(toViewController: UIViewController, transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popToViewController(toViewController, animated: false)
    }

    func pop(toRoot: Bool = false, transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        if toRoot {
            self.popToRootViewController(animated: false)
        } else {
            self.popViewController(animated: false)
        }
    }
}

public extension UINavigationController {
    func fadePush(_ viewController: UIViewController) {
        addTransition()
        pushViewController(viewController, animated: false)
    }
    
    func fadePop(toViewController: UIViewController) {
        addTransition()
        popToViewController(toViewController, animated: false)
    }
    
    func fadePop(toRoot: Bool = false) {
        addTransition()
        if toRoot {
            popToRootViewController(animated: false)
        } else {
            popViewController(animated: false)
        }
    }
}

public extension UINavigationController {
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
