import Foundation

struct Person: Codable {
    let id: Int
    let name: String
    let biography: String?
    let birthday: String
    let placeOfBirth: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, biography, birthday, placeOfBirth = "place_of_birth", profilePath = "profile_path"
    }
}

