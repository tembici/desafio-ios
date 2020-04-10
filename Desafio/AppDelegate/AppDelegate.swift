import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator! {
        didSet {
            ApiErrorHandler.sharedInstance.appCoordinator = coordinator
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()        
        
        setupCoordinator()
        setupKeyboardManager()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? FavoriteMovieDataSource(realmProvider: RealmProvider()).deleteAll()

    }
}

extension AppDelegate {
    
    private func setupCoordinator() {
        coordinator = AppCoordinator(window: window!)
        coordinator.start(with: nil)
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
}
