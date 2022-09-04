import Foundation

struct FavoriteMovieData: Decodable, Equatable {
    var movie: CinemaData
    var type: CinemaType
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.movie.id == rhs.movie.id
    }
    
}
