import Foundation
import UIKit
import RealmSwift

class RMGenre: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    required convenience init(genre: Genre) {
        self.init()
        id = genre.id
        name = genre.name
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    var entity: Genre {
        return Genre(
            id: id,
            name: name
        )
    }

}
