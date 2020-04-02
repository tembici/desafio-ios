import Foundation

class MovieCellViewModel: ViewModel {
    var movie: Movie
    var realmProvider: RealmProvider
    
    init(movie: Movie, realmProvider: RealmProvider) {
        self.movie = movie
        self.realmProvider = realmProvider
	}

}
