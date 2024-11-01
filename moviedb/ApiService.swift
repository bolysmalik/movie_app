import Foundation

class MovieService {
    // API Endpoints
    private let moviesURL = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")!
    private let movieDetailBaseURL = "https://api.themoviedb.org/3/movie/"
    private let creditsBaseURL = "https://api.themoviedb.org/3/movie/"
    private let personDetailBaseURL = "https://api.themoviedb.org/3/person/"
    
    private let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYWRkOWE0Y2Y1YzFlMDgzNzUzMjRhYzIyMzNkYjIzZCIsIm5iZiI6MTczMTUwMjI3My4yMzIwMDE1LCJzdWIiOiI2NzM0OWY0ODY3OGQzODU2YTc2YjYxNTUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.9ajI2qG-UwlzRUA6sK2uKzPi5yKMmJnrH7g581QyG7I"
    
    func fetchMovies(completion: @escaping (MovieModel?, Error?) -> Void) {
        var request = URLRequest(url: moviesURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                print("Fetch Movies Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                print("Fetch Movies HTTP Error: Status Code \(statusCode)")
                completion(nil, NSError(domain: "HTTPError", code: statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                print("Fetch Movies Error: Data is nil")
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }
            
            // Print JSON for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Fetch Movies JSON Response: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(MovieModel.self, from: data)
                completion(movies, nil)
            } catch {
                print("Fetch Movies Decoding Error: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchMovieDetailData(movieId: Int) async throws -> Movie {
        guard let url = URL(string: "\(movieDetailBaseURL)\(movieId)?language=en-US") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("Fetch Movie Detail HTTP Error: Status Code \(statusCode)")
            throw URLError(.badServerResponse)
        }
        
        // Debug print JSON response
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Fetch Movie Detail JSON Response: \(jsonString)")
        }
        
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie
        } catch {
            print("Fetch Movie Detail Decoding Error: \(error)")
            throw error
        }
    }
    
    func fetchMovieCredits(movieId: Int, completion: @escaping ([Actor]?, Error?) -> Void) {
        guard let url = URL(string: "\(creditsBaseURL)\(movieId)/credits?language=en-US") else {
            completion(nil, URLError(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                print("Fetch Movie Credits Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                print("Fetch Movie Credits HTTP Error: Status Code \(statusCode)")
                completion(nil, NSError(domain: "HTTPError", code: statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                print("Fetch Movie Credits Error: Data is nil")
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                return
            }
            
            // Print JSON for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Fetch Movie Credits JSON Response: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let credits = try decoder.decode(CreditsResponse.self, from: data)
                completion(credits.cast, nil)
            } catch {
                print("Fetch Movie Credits Decoding Error: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchPersonDetail(personId: Int) async throws -> Person {
        guard let url = URL(string: "\(personDetailBaseURL)\(personId)?language=en-US") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("Fetch Person Detail HTTP Error: Status Code \(statusCode)")
            throw URLError(.badServerResponse)
        }
        
        // Debug print JSON response
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Fetch Person Detail JSON Response: \(jsonString)")
        }
        
        do {
            let person = try JSONDecoder().decode(Person.self, from: data)
            return person
        } catch {
            print("Fetch Person Detail Decoding Error: \(error)")
            throw error
        }
    }
}
