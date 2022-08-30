import Foundation

class FilmsAPIClient {
    private let networkManager = NetworkManager()
    
    func getPopularMovie(completion: @escaping (Result<[CinemaData], Error>) -> Void) {
        self.networkManager.request(apiEnpoint: .popularFilms, for: PopularInCinema.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPopularTvShow(completion: @escaping (Result<[CinemaData], Error>) -> Void) {
        self.networkManager.request(apiEnpoint: .popularTvShow, for: PopularInCinema.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
