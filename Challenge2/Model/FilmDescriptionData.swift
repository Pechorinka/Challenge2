import Foundation

struct FilmDescriptionData: Decodable {
    
    var id: Int
    var poster_path: String
    var tagline: String
    var overview: String
    var genres: [Genres]
    var vote_average: Float
    var homepage: String
    
    ///Для фильмов
    var title: String?
    var release_date: String?
    var runtime: Double?
    
    ///Для сериалов
    var name: String?
    var first_air_date: String?
    var episode_run_time: [Double?]?
    var number_of_seasons: Int?
    var number_of_episodes: Int?
}

struct Genres: Codable {
    var id: Int
    var name: String
}
