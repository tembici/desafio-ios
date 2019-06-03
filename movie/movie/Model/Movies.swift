//
//  Movie.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 23/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation

struct Movies {
    static let instance = Movies()
    public private(set) var id: String!
    public private(set) var title: String!
    public private(set) var poster_path: String!
    public private(set) var release_date: String!
    public private(set) var genre_ids: String!
    public private(set) var overview: String!
}
