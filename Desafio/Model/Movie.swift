import Foundation

 public struct Movie: Codable {
    
    var movieCoverURL: String
    var movieName: String
    var releaseDate: String
    var genreIds: [Int] = []
    var overview: String
    var genres: [Genre] = []
    
    enum CodingKeys: String, CodingKey {
        case movieCoverURL = "poster_path"
        case movieName = "original_title"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview = "overview"
    }
    
}
