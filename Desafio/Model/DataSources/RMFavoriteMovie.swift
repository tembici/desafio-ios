import Foundation
import UIKit
import RealmSwift

class RMFavoriteMovie: Object {
    
    @objc dynamic var movieCoverURL: String = ""
    @objc dynamic var movieName: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var overview: String = ""
    
    let genres = List<RMGenre>()
    
    required convenience init(movie: Movie) {
        self.init()
        movieCoverURL = movie.movieCoverURL
        movieName = movie.movieName
        releaseDate = movie.releaseDate
        overview = movie.overview
        genres.append(objectsIn: movie.genres.map({ RMGenre(genre: $0) }))
    }

    override static func primaryKey() -> String? {
        return "movieCoverURL"
    }

    var entity: Movie {
        return Movie(
            movieCoverURL: movieCoverURL,
            movieName: movieName,
            releaseDate: releaseDate,
            genreIds: [],
            overview: overview,
            genres: genres.map({ $0.entity })
        )
    }
}
