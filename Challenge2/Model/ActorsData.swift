import Foundation

struct ActorsData: Codable {
    var id: Int
    var cast: [Cast]
}

struct Cast: Codable {
    var id: Int
    var name: String
    var character: String
    var profile_path: String
}
