//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: class {
    func display(viewModel: MoviesModels.FetchMovies.ViewModel)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic {
    
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?
    
    @IBOutlet private var collectionView: UICollectionView!
    
    var displayedMovies: [MoviesModels.FetchMovies.ViewModel.DisplayedMovie] = []
    
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
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
        self.collectionView.register(UINib(nibName: CoverCell.name, bundle: nil), forCellWithReuseIdentifier: CoverCell.name)
        self.interactor?.fetch(request: MoviesModels.FetchMovies.Request(index: 0))
    }
    
    func display(viewModel: MoviesModels.FetchMovies.ViewModel) {
        self.displayedMovies.append(contentsOf: viewModel.displayedMovies)
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let router = self.router, let identifier = segue.identifier else { return }
        let selector = NSSelectorFromString("routeTo\(identifier)WithSegue:sender:")
        if router.responds(to: selector) {
            router.perform(selector, with: segue, with: sender)
        }
    }
    
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.name, for: indexPath)
        (cell as? CoverCell)?.prepare(viewModel: self.displayedMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        // horizontal margins
        let minimumInteritemSpacing = collectionViewLayout.minimumInteritemSpacing
        let leftMargin = collectionViewLayout.sectionInset.left
        let rightMargin = collectionViewLayout.sectionInset.right
        
        // width and height for cell
        let width = (collectionView.bounds.width - minimumInteritemSpacing - leftMargin - rightMargin) / 2
        let height = 1.5 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // check if we need to prefetch new items
        guard let indexPath = indexPaths.last else { return }
        self.interactor?.fetch(request: MoviesModels.FetchMovies.Request(index: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
    }
    
}
