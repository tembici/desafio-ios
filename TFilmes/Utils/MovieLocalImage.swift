//
//  MovieLocalImage.swift
//  TFilmes
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 07/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MovieLocalImage {

    private static let imagesFolder = "movies-image"

    static func getFileDir(imageName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent("\(self.imagesFolder)\(imageName)")
    }

    static func save(imageData: Data?, imageURL: URL?) -> String? {
        guard let data = imageData, let imageName = imageURL?.lastPathComponent else { return nil }

        let fileDir = MovieLocalImage.getFileDir(imageName: imageName)

        do {
            try data.write(to: fileDir)
        } catch {
            return nil
        }

        return imageName
    }

    static func delete(imageURL: URL?) {
        guard let imageName = imageURL?.lastPathComponent else { return }
    
        let fileDir = MovieLocalImage.getFileDir(imageName: imageName)
        try? FileManager.default.removeItem(at: fileDir)
    }
}

