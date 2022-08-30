
import Foundation

struct FilmData: Codable {
    var id: Int = 1
    var overview: String = "Просто описание фильма"
    var title: String = "Тор"
    var poster_path: String?
    var poster: String
    var release_date: String = "22.02.2022"
}
