import Foundation

class FavoriteMovieViewModel: ViewModel {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
