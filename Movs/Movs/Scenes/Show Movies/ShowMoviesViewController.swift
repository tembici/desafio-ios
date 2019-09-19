//
//  ShowMoviesViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesDisplayLogic: class {
  func displaySomething(viewModel: ShowMovies.Something.ViewModel)
}

class ShowMoviesViewController: UIViewController, ShowMoviesDisplayLogic {
    var interactor: ShowMoviesBusinessLogic?
    var router: (NSObjectProtocol & ShowMoviesRoutingLogic & ShowMoviesDataPassing)?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            
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

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = ShowMovies.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: ShowMovies.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
