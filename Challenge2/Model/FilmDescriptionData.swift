import UIKit

struct FilmDescriptionData: Codable {
    
    var id: Int?
    var poster_path: String?
    var title: String?
    var tagline: String?
    var overview: String?
    var genres: Genres?
    var vote_average: Float?
    var release_date: String?
    var runtime: Int?
    var homepage: String?
    
    ///Для сериалов
    var name: String?
    var first_air_date: String?
    var episode_run_time: Int?
    var number_of_seasons: Int?
    var number_of_episodes: Int?
}

struct Genres: Codable {
    var id: Int
    var name: String
}
