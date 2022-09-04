import Foundation
import UIKit

enum CinemaType: Int, Codable {
    case films
    case tvShows
}

class FilmsAPIClient {
    private let networkManager = NetworkManager()
    
    func getCinema(of type: CinemaType, cinemaId: Int, completion: @escaping (Result<(FilmDescriptionData, ActorsData), Error>) -> Void) {
        switch type {
        case .films:
            self.getFilmDetailInfo(filmID: cinemaId, completion: completion)
        case .tvShows:
            self.getTvShowDetailInfo(filmID: cinemaId, completion: completion)
        }
    }
    
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
    
    func goTheCinemaSite(cinemaId: Int) {
        let url = self.networkManager.apiConstructor.getTheCinemaSite(with: cinemaId)
        UIApplication.shared.open(url!,
                                  options: [:],
                                  completionHandler: nil
        )
    }
    
    func goTheTvShowSite(cinemaId: Int) {
        let url = self.networkManager.apiConstructor.getTheTvShowSite(with: cinemaId)
        UIApplication.shared.open(url!,
                                  options: [:],
                                  completionHandler: nil
        )
    }

    func getFilmDetailInfo(
        filmID: Int,
        completion: @escaping (Result<(FilmDescriptionData, ActorsData), Error>) -> Void
    ) {
        let group = DispatchGroup()
        
        var _filmDescription: FilmDescriptionData? = nil
        var _castInfo: ActorsData? = nil
        
        guard let urlFilm = self.networkManager.apiConstructor.makeGetFilmDetailInfoURL(with: filmID) else { return }
        guard let urlCast = self.networkManager.apiConstructor.getFilmCast(with: filmID) else { return }
        
        group.enter()
        self.networkManager.request(
            for: urlFilm,
            for: FilmDescriptionData.self) { result in
                group.leave()
                
                switch result {
                case .success(let filmDescription):
                    _filmDescription = filmDescription
                case .failure:
                    break
                }
            }
        
        group.enter()
        self.networkManager.request(
            for: urlCast,
            for: ActorsData.self) { result in
                group.leave()
                
                switch result {
                case .success(let castInfo):
                    _castInfo = castInfo
                case .failure:
                    break
                }
            }
        
        group.notify(queue: .main) {
            guard let _filmDescription = _filmDescription, let _castInfo = _castInfo else { return }
            completion (.success((_filmDescription, _castInfo)))
        }
    }
    
    func getTvShowDetailInfo(
        filmID: Int,
        completion: @escaping (Result<(FilmDescriptionData, ActorsData), Error>) -> Void
    ) {
        let group = DispatchGroup()
        
        var _filmDescription: FilmDescriptionData? = nil
        var _castInfo: ActorsData? = nil
        
        guard let urlFilm = self.networkManager.apiConstructor.makeGetTvShowDetailInfoURL(with: filmID) else { return }
        guard let urlCast = self.networkManager.apiConstructor.getTvShowCast(with: filmID) else { return }
        
        group.enter()
        self.networkManager.request(
            for: urlFilm,
            for: FilmDescriptionData.self) { result in
                group.leave()
                
                switch result {
                case .success(let filmDescription):
                    _filmDescription = filmDescription
                case .failure:
                    break
                }
            }
        
        group.enter()
        self.networkManager.request(
            for: urlCast,
            for: ActorsData.self) { result in
                group.leave()
                
                switch result {
                case .success(let castInfo):
                    _castInfo = castInfo
                case .failure:
                    break
                }
            }
        
        group.notify(queue: .main) {
            guard let _filmDescription = _filmDescription, let _castInfo = _castInfo else { return }
            completion (.success((_filmDescription, _castInfo)))
        }
    }
}

