import Foundation

struct PopularInCinema: Decodable {
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

extension CinemaData {
    
    init(filmInfo: FilmDescriptionData) {
        self.init(
            poster_path: filmInfo.poster_path,
            id: filmInfo.id, title: filmInfo.title,
            name: filmInfo.name, release_date: filmInfo.release_date,
            first_air_date: filmInfo.first_air_date
        )
    }
    
}

