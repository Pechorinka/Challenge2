import Foundation

struct ActorsData: Codable {
    var cast: [Cast]
}

struct Cast: Codable {
    var id: Int
    var name: String
    var profile_path: String?
    
    ///Для фильма
    var character: String?
    
    ///Для фильма
    var roles: [Сharacter]?
}


struct Сharacter: Codable {
    var character: String?
}
