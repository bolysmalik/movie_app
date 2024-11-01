struct CreditsResponse: Decodable {
    let cast: [Actor]
}

struct Actor: Decodable {
    let name: String
    let character: String?
    let profilePath: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath
        case id
    }
}
