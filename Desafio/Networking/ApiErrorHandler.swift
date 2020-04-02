import Foundation

final class ApiErrorHandler {
    
    static let sharedInstance = ApiErrorHandler()
    
    var appCoordinator: AppCoordinator!
    
    private init() {}
    
}
