import Foundation

struct PopularInCinema: Codable {
    var results: [CinemaData] = []
}

struct CinemaData: Codable {
    var poster_path: String
    var id: Int
    var title: String?
    var name: String?
    var release_date: String?
    var first_air_date: String?
}

