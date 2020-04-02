import Foundation
import RealmSwift

public protocol MovieDataLogic: class {
    var provider: RealmProvider { get set }
    func saveMovie(movie: Movie) throws
    func removeMovie(movie: Movie) throws
}

class FavoriteMovieDataSource: MovieDataLogic {
    var provider: RealmProvider
    
    public init(realmProvider: RealmProvider) {
        self.provider = realmProvider
    }
    
    public func saveMovie(movie: Movie) throws {
        let realm = try provider.loadRealm()

        try realm.safeWrite {
            realm.add(RMFavoriteMovie(movie: movie), update: .all)
        }
    }
    
    public func removeMovie(movie: Movie) throws {
        let realm = try provider.loadRealm()
        if let movieToDelete = realm.object(ofType: RMFavoriteMovie.self, forPrimaryKey: movie.movieCoverURL) {
            try realm.safeWrite {
                realm.delete(movieToDelete)
            }
        }
    }
    
    public func deleteAll() throws {
        let realm = try provider.loadRealm()
        try realm.safeWrite {
            realm.deleteAll()
        }        
    }
    
    public func objectExist (id: String) -> Bool {
        // swiftlint:disable force_try

        return try! RealmProvider().loadRealm().object(ofType: RMFavoriteMovie.self, forPrimaryKey: id) != nil
    }
}
