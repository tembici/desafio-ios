@testable import todo

final class AuthCoordinatorSpy: AuthCoordinator {
    var authSceneWasFinished = false
    
    override func finish() {
        authSceneWasFinished = true
    }
}
