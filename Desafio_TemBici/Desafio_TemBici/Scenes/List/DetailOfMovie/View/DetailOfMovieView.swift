// 
//  DetailOfMovieView.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//

import UIKit

protocol DetailOfMovieView: class {
    func configure()
    func display(detailModel: DetailModel)
    func error(message: String)
    func setImage(image: UIImage)
}
