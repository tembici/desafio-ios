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
    
    @NSManaged var title: String?
    var poster: String?
    
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
        case title
        case posterPath
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.poster = try values.decode(String.self, forKey: .posterPath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.poster, forKey: .posterPath)
    }
    
}
