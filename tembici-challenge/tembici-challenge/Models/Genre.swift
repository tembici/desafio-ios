//
//  Genre.swift
//  tembici-challenge
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//
import Foundation

struct Genres: Hashable, Codable {
  
    let genres: [Genre]
}

struct Genre: Hashable, Codable, Identifiable{
    let id: Int
    let name: String
}

