// 
//  ListOfFavoritesView.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

protocol ListOfFavoritesView: class {
    func configureUI()
    func startLoading()
    func stopLoading()
    func reloadData()
    func display(message: String)
    func tableViewIsHidden()
    func tableViewNotHidden()
}
