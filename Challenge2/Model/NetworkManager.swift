
import UIKit

protocol NetworkManagerDelegate {
    func didUpdateCinemas(cinemas: [CinemaData])
    func didFailWithError(error: Error)
}

class NetworkManager {

    var delegate: NetworkManagerDelegate?
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "ab31c35bc448b2b8ac1df7a1fa526ca7"
    private let session = URLSession(configuration: .default)
    
    func getPopularMovie() {
        let urlString = "\(self.baseUrl)/movie/popular?api_key=\(self.apiKey)&language=en-US&page=1"
        print(urlString)
        
        guard let url = URL(string: urlString) else { return }
      
        self.session.dataTask(with: url) {
            [weak self] (data, _, error) in
            guard let self = self else { return }
            self.handleResponse(with: data, error: error)
        }.resume()
    }
}

private extension NetworkManager {
    
    func handleResponse(with data: Data?, error: Error?) {
        if let error = error {
            self.delegate?.didFailWithError(error: error)
            return
        }
       
        guard let safeData = data,
              let popularCinemas = self.parseJSON(safeData) else {
            self.delegate?.didFailWithError(error: NSError(domain: "NetworkManager", code: 1))
            return
        }
        
        self.delegate?.didUpdateCinemas(cinemas: popularCinemas)
    }
    
    func parseJSON(_ data: Data) -> [CinemaData]? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(PopularInCinema.self, from: data)
            let lastPrice = decoderData.popularInCinema
            print(lastPrice)
            return lastPrice
        } catch {
            self.delegate?.didFailWithError(error: error)
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
