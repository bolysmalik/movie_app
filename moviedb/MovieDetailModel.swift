import Foundation

// Define the Movie model to match the JSON data structure
struct Movie: Codable {
//    let adult: Bool
    let backdropPath: String?
//    let budget: Int
    let genres: [Genre]?
//    let homepage: String
    let id: Int?
//    let imdbID: String
//    let originalLanguage: String
    let originalTitle: String?
    let overview: String?
//    let popularity: Double
    let posterPath: String?
//    let productionCompanies: [ProductionCompany]
    let releaseDate: String?
//    let revenue: Int
//    let runtime: Int
//    let spokenLanguages: [SpokenLanguage]
//    let status: String
//    let tagline: String
    let title: String?
    let voteAverage: Double?
//    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
//        case adult
        case backdropPath = "backdrop_path"
//        case budget
        case genres
//        case homepage
        case id
//        case imdbID = "imdb_id"
//        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
//        case popularity
        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
//        case revenue
//        case runtime
//        case spokenLanguages = "spoken_languages"
//        case status
//        case tagline
        case title
        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1
        case name
    }
}
