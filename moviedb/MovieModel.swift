import Foundation

// MARK: - Welcome
struct MovieModel: Codable {
    let page: Int
    let results: [MovieDetail]
//    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}

// MARK: - MovieDetail
struct MovieDetail: Codable {
//    let adult: Bool?
//    let backdropPath: String?
//    let genreIDS: [Int]?
    let id: Int?
//    let originalLanguage: OriginalLanguage
//    let originalTitle, overview: String?
//    let popularity: Double?
    let posterPath: String?
//    let releaseDate: String?
    let title: String?
//    let video: Bool?
//    let voteAverage: Double?
//    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
        case posterPath
//        case releaseDate = "release_date"
        case title
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}


enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}
