import UIKit

struct PopularInCinema: Codable {
    var popularInCinema: [CinemaData] = []

struct CinemaData: Codable {
    var poster_path: String?
    var id: Int?
    var title: String?
    var release_date: String?
}



