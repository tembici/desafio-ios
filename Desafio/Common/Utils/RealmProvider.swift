import Foundation
import RealmSwift

public class RealmProvider {
    
    public let currentSchemaVersion: UInt64 = 1
    
    private lazy  var configuration: Realm.Configuration = {
        if  NSClassFromString("XCTest") != nil {
            return Realm.Configuration(inMemoryIdentifier: "test")
        }
        var config = Realm.Configuration(
            schemaVersion: currentSchemaVersion,
            migrationBlock: { [weak self] _, oldSchemaVersion in
                guard let this = self else { return }
                if oldSchemaVersion < this.currentSchemaVersion {}
        })
        Realm.Configuration.defaultConfiguration = config
        return Realm.Configuration.defaultConfiguration
    }()
    
    public func loadRealm() throws -> Realm {
        let realm = try Realm(configuration: configuration)
        return realm
    }
    
    public init() {}
}
