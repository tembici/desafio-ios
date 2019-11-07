//
//  Favorite+CoreDataProperties.swift
//  Desafio_TemBici
//
//  Created by Victor Rodrigues on 07/11/19.
//  Copyright © 2019 Victor Rodrigues. All rights reserved.
//
//

import Foundation
import CoreData

extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var url: String?
    @NSManaged public var date: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var overview: String?

}
