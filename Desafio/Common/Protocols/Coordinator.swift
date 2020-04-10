import UIKit

public protocol CoordinatorPath { }

public enum StartType {
    case modal(animated: Bool), root(withNavigationController: Bool), tabItem(title: String?, image: UIImage?, selectedImage: UIImage?, animated: Bool)
}

public protocol CoordinatorProtocol: class {
    func route(to path: CoordinatorPath)
    func finish()
}

public protocol Coordinator: CoordinatorProtocol {
    associatedtype ModelDependency
    
    var window: UIWindow { get }
    
    init(window: UIWindow)
    
    func start(as startType: StartType, with input: ModelDependency?)
}

public extension Coordinator {
    
    var currentViewController: UIViewController? {
        guard let rootViewController = window.rootViewController else { return nil }
        return currentViewController(root: rootViewController)
    }
    
    var currentTabBarController: UITabBarController? {
        if let tabController = currentViewController as? UITabBarController {
            return tabController
        } else {
            return currentViewController?.tabBarController
        }
    }
    
    private func controllerRoot(for viewController: UIViewController) -> UIViewController? {
        if let tabBarController = viewController as? UITabBarController,
            let selected = tabBarController.selectedViewController {
            return currentViewController(root: selected)
        } else if let navigationController = viewController as? UINavigationController,
            let top = navigationController.topViewController {
            return currentViewController(root: top)
        }
        
        return viewController
    }
    
    private func currentViewController(root: UIViewController) -> UIViewController? {
        guard let presented = root.presentedViewController else {
            return controllerRoot(for: root)
        }
        
        return controllerRoot(for: presented)
    }
    
}

public extension Coordinator {
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        if let tabBarController = currentTabBarController {
            tabBarController.present(viewController, animated: animated, completion: nil)
        } else {
            currentViewController?.present(viewController, animated: animated, completion: nil)
        }
    }
    
    private func root(_ viewController: UIViewController) {
        if let snapshot = (window.snapshotView(afterScreenUpdates: true)) {
            viewController.view.addSubview(snapshot)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            if let statusBar = UIApplication.shared.statusBarView, !UIApplication.shared.isStatusBarHidden {
                statusBar.removeFromSuperview()
                window.addSubview(statusBar)
            }
            
            UIView.transition(with: snapshot, duration: 0.4, options: [], animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
    
    func dismiss(animated: Bool = true) {
        currentViewController?.dismiss(animated: animated, completion: nil)
    }
    
    func show(viewController: UIViewController, as startType: StartType) {
        switch startType {
        case .modal(let animated):
            present(viewController, animated: animated)
        case .root(let withNavigation):
            if withNavigation {
                let navController = UINavigationController(rootViewController: viewController)
                navController.navigationBar.isHidden = true
                navController.navigationBar.barStyle = .blackOpaque
                root(navController)
            } else {
                root(viewController)
            }
        case .tabItem(let title, let image, let selectedImage, let animated):
            assert(currentTabBarController != nil, "Não existe uma TabBarController ativa, a TabBarController precisa ser apresentada antes de adicionar as tabs")
            let navController = UINavigationController(rootViewController: viewController)
            navController.navigationBar.isHidden = true
            navController.navigationBar.barStyle = .blackOpaque
            navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
            viewController.definesPresentationContext = true
            currentTabBarController?.setViewControllers((currentTabBarController?.viewControllers ?? []) + [navController], animated: animated)
        }
    }
}
