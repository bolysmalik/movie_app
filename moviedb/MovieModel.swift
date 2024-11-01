import Foundation

struct MovieModel: Codable {
    let page: Int
    let results: [MovieDetail]
    
    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

struct MovieDetail: Codable {
    let id: Int?
    let posterPath: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath
        case title
    }
}


enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}
