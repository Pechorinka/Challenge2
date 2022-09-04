
import UIKit

enum APIEndpoints: String {
    case popularFilms = "movie/popular"
    case popularTvShow = "tv/popular"
}

class FilmsAPIConstructor {
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "ab31c35bc448b2b8ac1df7a1fa526ca7"
    
    func makeURL(for endpoint: APIEndpoints) -> URL? {
        let urlString = "\(self.baseUrl)/\(endpoint.rawValue)?api_key=\(self.apiKey)&language=en-US"
        return URL(string: urlString)
    }
    
    func makeGetFilmDetailInfoURL(with filmID: Int) -> URL? {
        let urlString = "\(self.baseUrl)/movie/\(filmID)?api_key=\(self.apiKey)&language=en-US"
        return URL(string: urlString)
    }
    
    func makeGetTvShowDetailInfoURL(with filmID: Int) -> URL? {
        let urlString = "\(self.baseUrl)/tv/\(filmID)?api_key=\(self.apiKey)&language=en-US"
        return URL(string: urlString)
    }
    
    func getImageURL(with posterPath: String) -> URL? {
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        return URL(string: urlString)
    }
    
    func getFilmCast(with filmID: Int) -> URL? {
        let urlString = "\(self.baseUrl)/movie/\(filmID)/credits?api_key=\(self.apiKey)&language=en-US"
        return URL(string: urlString)
    }
    
    func getTvShowCast(with filmID: Int) -> URL? {
        let urlString = "\(self.baseUrl)/tv/\(filmID)/aggregate_credits?api_key=\(self.apiKey)&language=en-US"
        return URL(string: urlString)
    }
    
    func getTheCinemaSite(with filmID: Int) -> URL? {
        let urlString = "https://www.themoviedb.org/movie/\(filmID)"
        return URL(string: urlString)
    }
    
    func getTheTvShowSite(with filmID: Int) -> URL? {
        let urlString = "https://www.themoviedb.org/tv/\(filmID)"
        return URL(string: urlString)
    }
}

class NetworkManager {
    let apiConstructor = FilmsAPIConstructor()
    private let session = URLSession(configuration: .default)
    
    func request<D: Decodable>(
        apiEnpoint: APIEndpoints,
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        guard let url = self.apiConstructor.makeURL(for: apiEnpoint) else { return }
        self.request(for: url, for: dataModel, completion: completion)
    }
    
    func request<D: Decodable>(
        for url: URL,
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        self.session.dataTask(with: url) {
            [weak self] (data, _, error) in
            guard let self = self else { return }
            self.handleResponse(with: data, error: error, completion: completion)
        }.resume()
    }
}

private extension NetworkManager {
    
    func handleResponse<D: Decodable>(with data: Data?, error: Error?, completion: @escaping  (Result<D, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
       
        guard let data = data,
              let model = self.parseJSON(data, to: D.self) else {
            completion(.failure(NSError(domain: "NetworkManager", code: 1)))
            return
        }
        
        DispatchQueue.main.async {
            completion(.success(model))
        }
    }
    
    func parseJSON<D: Decodable>(_ data: Data, to model: D.Type) -> D? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(model, from: data)
        } catch {
            print("parse error: \(error)")
            return nil
        }
    }
}


//Даные о касте https://api.themoviedb.org/3/movie/550/credits?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US

//Данные о касте сериала https://api.themoviedb.org/3/tv/94997/aggregate_credits?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US
