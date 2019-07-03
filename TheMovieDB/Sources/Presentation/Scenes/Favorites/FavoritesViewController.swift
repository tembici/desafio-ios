//
//  FavoritesViewController.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 03/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func display(viewModel: FavoritesModels.FetchMovies.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    @IBOutlet private var tableView: UITableView!
    
    var interactor: FavoritesInteractorProtocol?
    var router: FavoritesRouterProtocol?
    
    var displayedMovies: [FavoritesModels.FetchMovies.ViewModel.DisplayedMovie] = []
    
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = Color.yellow
        self.tableView.register(UINib(nibName: FavoriteCell.name, bundle: nil), forCellReuseIdentifier: FavoriteCell.name)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor?.fetch(request: FavoritesModels.FetchMovies.Request())
    }
    
    func display(viewModel: FavoritesModels.FetchMovies.ViewModel) {
        self.displayedMovies = viewModel.displayedMovies
        self.tableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.name, for: indexPath)
        (cell as? FavoriteCell)?.prepare(viewModel: self.displayedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.displayedMovies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.interactor?.unfavorite(request: FavoritesModels.UnfavoriteMovie.Request(index: indexPath.row))
        }
    }
    
}
