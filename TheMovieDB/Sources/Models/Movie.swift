//
//  Movie.swift
//  TheMovieDB
//
//  Created by Marcos Kobuchi on 02/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import CoreData

final class Movie: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var title: String?
    @NSManaged var poster: String?
    @NSManaged var overview: String?
    @NSManaged var releaseDate: String?
    @NSManaged var genre: String?
    
    @NSManaged var favorited: Bool
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: String(describing: self))
    }
    
    convenience init() {
        let entityDescription: NSEntityDescription = CoreDataManager.shared.create(String(describing: type(of: self)))
        self.init(entity: entityDescription, insertInto: nil)
    }
    
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
        case overview
        case genreIds
        case releaseDate
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.poster = try values.decode(String.self, forKey: .posterPath)
        self.overview = try values.decode(String.self, forKey: .overview)
        let genres = try values.decode([Int].self, forKey: .genreIds)
        self.genre = genres.map({ $0.description }).joined(separator: " ")
        self.releaseDate = try values.decode(String.self, forKey: .releaseDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.releaseDate, forKey: .releaseDate)
    }
    
}
