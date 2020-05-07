//
//  SplashViewController.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {

    private lazy var presenter: SplashPresenterToView = {
        return SplashPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

}

// MARK: - SplashViewToPresenter

extension SplashViewController: SplashViewToPresenter {

    func continueApp() {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "segueToNavigation", sender: self)
        }
    }

    func showErrorMessage() {
        let title = NSLocalizedString("splash.error.title", comment: "Error title")
        let message = NSLocalizedString("splash.error.message", comment: "Error message")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let tryAgainTitle = NSLocalizedString("splash.error.try_agin", comment: "Error try again button")
        let tryAgainAction = UIAlertAction(title: tryAgainTitle, style: .default) { [weak self] _ in
            self?.presenter.tryToGetGenresTapped()
        }

        alert.addAction(tryAgainAction)

        let cancelTitle = NSLocalizedString("splash.error.cancel", comment: "Error cancel button")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { [weak self] _ in
            self?.continueApp()
        }

        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

}
