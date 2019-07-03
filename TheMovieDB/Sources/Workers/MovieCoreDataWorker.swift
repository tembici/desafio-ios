//
//  ServerCoreDataWorker.swift
//  MeReach
//
//  Created by Marcos Kobuchi on 01/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import CoreData

enum MovieError: LocalizedError {
    case database(description: String)
}

final class MovieCoreDataWorker: MovieWorkerProtocol {
    
    func fetch(favorited: Bool) throws -> [Movie] {
        do {
            let request: NSFetchRequest<Movie> = Movie.fetchRequest()
            request.predicate = NSPredicate(format: "favorited == %@", NSNumber(value: favorited))
            return try CoreDataManager.shared.fetch(request)
        } catch {
            throw MovieError.database(description: error.localizedDescription)
        }
    }
    
    func create(_ server: Movie) throws {
        do {
            try CoreDataManager.shared.insert(server)
        } catch {
            throw MovieError.database(description: error.localizedDescription)
        }
    }
    
    func delete(_ server: Movie) throws {
        do {
            try CoreDataManager.shared.delete(server)
        } catch {
            throw MovieError.database(description: error.localizedDescription)
        }
    }
    
}

// MARK: - Server Worker API

protocol MovieWorkerProtocol {
    func fetch(favorited: Bool) throws -> [Movie]
    func create(_ server: Movie) throws
    func delete(_ server: Movie) throws
}
