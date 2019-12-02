//
//  Favorites+CoreDataProperties.swift
//  Movs
//
//  Created by Elias Amigo on 01/12/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import CoreData

extension Favorites {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }
    
    @NSManaged public var overview: String?
    @NSManaged public var id: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}
