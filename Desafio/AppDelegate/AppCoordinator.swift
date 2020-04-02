import UIKit

protocol AppCoordinatorDelegate: class {
}

protocol AppCoordinatorProcotol: CoordinatorProtocol {
    func back()
}

enum AppPath: CoordinatorPath {
    case detail(movie: Movie)
}

final class AppCoordinator: Coordinator, AppCoordinatorProcotol {
    
    typealias ModelDependency = Void
    let window: UIWindow
    let tabBarController: UITabBarController
    let realmProvider = RealmProvider()
    required init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
    }
    
    func start(as startType: StartType = .root(withNavigationController: false), with input: Void?) {
        setupTabBar()
        show(viewController: tabBarController, as: startType)
        setupTabs(input: input)

    }
    
    func route(to path: CoordinatorPath) {
        guard let path = path as? AppPath else { return }
        switch path {
        case .detail(let movie):
            let viewController = MovieDetailViewController(viewModel: MovieDetailViewModel(movie: movie, coordinator: self, realmProvide: realmProvider))
            show(viewController: viewController, as: .modal(animated: true))
        }
    }
    
    private func setupTabBar() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.unselectedItemTintColor = UIColor.gray
        tabBarAppearance.tintColor = UIColor.black
        tabBarAppearance.barTintColor = Constants.backgroundYellowColor
        tabBarAppearance.isTranslucent = false
    
    }
    
    private func setupTabs(input: ModelDependency?) {
        setupListTab()
        setupFavoritList()
    }
    
    private func setupListTab() {
        let viewController = MovieListViewController(viewModel: MovieListViewModel(coordinator: self))
        show(viewController: viewController, as: .tabItem(title: R.string.movs.listTabTitle(), image: R.image.ic_list(), selectedImage: R.image.ic_list(), animated: true))
    }

    private func setupFavoritList() {
        let viewController = FavoriteListViewController(viewModel: FavoriteListViewModel(realmProvider: realmProvider))
        show(viewController: viewController, as: .tabItem(title: R.string.movs.listTabTitle(), image: R.image.ic_favorite_gray(), selectedImage: R.image.ic_favorite_gray(), animated: true))
    }
    
    func finish() { }
    
    func back() {
        dismiss(animated: true)
    }
}
