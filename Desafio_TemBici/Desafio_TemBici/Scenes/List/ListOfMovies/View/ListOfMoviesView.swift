// 
//  ListOfMoviesView.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

protocol ListOfMoviesView: class {
    func removeBlackSpace()
    func configureUI()
    func error(message: String)
    func collectionIsHidden()
    func collectionNotHidden()
    func startLoading()
    func stopLoading()
    func reloadData()
}
