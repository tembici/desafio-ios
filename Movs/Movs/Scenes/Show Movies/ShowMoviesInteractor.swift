//
//  ShowMoviesInteractor.swift
//  Movs
//
//  Created by Miguel Pimentel on 18/09/19.
//  Copyright (c) 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol ShowMoviesBusinessLogic {
    func doSomething(request: ShowMovies.Something.Request)
}

protocol ShowMoviesDataStore {
    //var name: String { get set }
}

class ShowMoviesInteractor: ShowMoviesBusinessLogic, ShowMoviesDataStore {
    var presenter: ShowMoviesPresentationLogic?
    var worker: ShowMoviesWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: ShowMovies.Something.Request) {
        worker = ShowMoviesWorker()
        worker?.doSomeWork()

        let response = ShowMovies.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
