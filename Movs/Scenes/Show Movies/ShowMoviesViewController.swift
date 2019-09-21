//
//  ShowMoviesViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesDisplayLogic: class {
  func displayMovies(viewModel: ShowMovies.fetchMovies.ViewModel)
}

class ShowMoviesViewController: UIViewController {
    
    var content = [Any]()
    
    var interactor: ShowMoviesBusinessLogic?
    var router: (NSObjectProtocol & ShowMoviesRoutingLogic & ShowMoviesDataPassing)?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(MovieCollectionViewCell.self)
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ShowMoviesInteractor()
        let presenter = ShowMoviesPresenter()
        let router = ShowMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK:

    func doSomething() {
        let request = ShowMovies.fetchMovies.Request()
        interactor?.fetchData(request: request)
    }
}

// MARK: - Display Logic -

extension ShowMoviesViewController: ShowMoviesDisplayLogic {

    func displayMovies(viewModel: ShowMovies.fetchMovies.ViewModel) {
        DispatchQueue.main.async {
            self.content += viewModel.content
            self.collectionView.reloadData()
        }
    }
}

extension ShowMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension ShowMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: content[indexPath.row])
        
        return cell
    }
}

