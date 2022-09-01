
import Foundation

enum APIEndpoints: String {
    case popularFilms = "movie/popular"
    case popularTvShow = "tv/popular"
}

class NetworkManager {
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "ab31c35bc448b2b8ac1df7a1fa526ca7"
    private let session = URLSession(configuration: .default)
    
    func request<D: Decodable>(
        apiEnpoint: APIEndpoints,
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        let urlString = "\(self.baseUrl)/\(apiEnpoint.rawValue)?api_key=\(self.apiKey)&language=en-US&page=1"
        print(urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        self.session.dataTask(with: url) {
            [weak self] (data, _, error) in
            guard let self = self else { return }
            self.handleResponse(with: data, error: error, completion: completion)
        }.resume()
    }
    
    
    func getImage(imageType: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageURL = URL(string: imageType) else { return }
        
        let session = URLSession(configuration: .default)

        
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        task.resume()
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



//популярные фильмы https://api.themoviedb.org/3/movie/popular?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US&page=1
//Данные о конкретном фильме https://api.themoviedb.org/3/movie/550?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7
//Даные о касте https://api.themoviedb.org/3/movie/550/credits?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US

//Популярные сериалы https://api.themoviedb.org/3/tv/popular?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US&page=1
//Данные о конкретном сериале https://api.themoviedb.org/3/tv/94997?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US
//Данные о касте сериала https://api.themoviedb.org/3/tv/94997/aggregate_credits?api_key=ab31c35bc448b2b8ac1df7a1fa526ca7&language=en-US
