import Foundation

struct FavoriteMovieData: Codable, Equatable {
    var movie: CinemaData
    var type: CinemaType
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.movie.id == rhs.movie.id
    }
    
}

class FavoriteMovieDataStorage: Codable {
    static let fileName = "FavoriteMovieDataStorage"
    
    private(set) var films = [FavoriteMovieData]()
    
    private lazy var favoritesStorage: CodableStorage = {
        let path = self.getDocumentsDirectory()
        let disk = DiskStorage(path: path)
        return CodableStorage(storage: disk)
    }()
    
    init() {
        self.films = self.loadFavoritesCinema()
    }
    
    func updateFilms(_ films: [FavoriteMovieData]) {
        self.films = films
        try? self.favoritesStorage.save(self, for: Self.fileName)
    }
    
}

private extension FavoriteMovieDataStorage {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadFavoritesCinema() -> [FavoriteMovieData] {
        let cachedStorage: FavoriteMovieDataStorage? = try? self.favoritesStorage.fetch(for: Self.fileName)
        return cachedStorage?.films ?? []
    }
    
}
