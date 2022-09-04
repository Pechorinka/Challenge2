import UIKit

protocol ISecondViewControllerDelegate: AnyObject {
    
    func didCinemaFavoriteStatusChanged(
        _ cinemaData: CinemaData,
        cinemaType: CinemaType,
        isFavorite: Bool
    )
}

class SecondViewController: UIViewController {
    
    weak var delegate: ISecondViewControllerDelegate?
    
    let apiClient = FilmsAPIClient()
    private let apiConstructor = FilmsAPIConstructor()
    var cinemaType: CinemaType = .films
    var filmID: Int = 0
    
    var isFavorite = false {
        didSet {
            self.bookmarkButton.tintColor = self.isFavorite ? .red : .white
            self.bookmarkButton.image = self.isFavorite ? .init(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)) : .init(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default))
        }
    }
    
    private var filmInfo: FilmDescriptionData?
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark", withConfiguration: config),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.bookmarkButtonTapped)
        )
        button.tintColor = self.isFavorite ? .red : .white
        button.image = self.isFavorite ? .init(systemName: "bookmark.fill", withConfiguration: config) : .init(systemName: "bookmark", withConfiguration: config)
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left", withConfiguration: config),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.popViewControler)
        )
        button.tintColor = UIColor.white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.view.backgroundColor = .black
        
        self.navigationItem.rightBarButtonItem = self.bookmarkButton
        
        self.navigationItem.leftBarButtonItem = self.closeButton
        
        self.apiClient.getCinema(of: self.cinemaType, cinemaId: self.filmID) { result in
            switch result {
            case .success((let cinemaInfo, let castInfo)):
                self.setupViewWithData(cinemaInfo, castInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func bookmarkButtonTapped() {
        self.isFavorite.toggle()
        guard let filmInfo = filmInfo else { return }
        
        self.delegate?.didCinemaFavoriteStatusChanged(
            .init(filmInfo: filmInfo),
            cinemaType: self.cinemaType,
            isFavorite: self.isFavorite
        )
    }
    
    @objc func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViewWithData(_ filmInfo: FilmDescriptionData, _ castInfo: ActorsData) {
        self.filmInfo = filmInfo
        let filmInfoView = self.makeFilmInfoView(with: filmInfo, modelCast: castInfo)
        
        self.view.addSubview(filmInfoView)
        filmInfoView.pin(to: self.view)
    }
    
    func makeFilmInfoView(with modelFilm: FilmDescriptionData, modelCast: ActorsData) -> SecondView {
        let posterPath = self.apiConstructor.getImageURL(with: modelFilm.poster_path)
        
        let view = SecondView(
            nameFilm: (modelFilm.title ?? modelFilm.name) ?? "Error",
            year: dateFromWebtoApp((modelFilm.release_date ?? modelFilm.first_air_date) ?? "2020"),
            genres: modelFilm.genres.map { $0.name },
            runtime: (modelFilm.runtime ?? modelFilm.episode_run_time?[0]) ?? 800 ,
            getStarsRating: modelFilm.vote_average,
            filmDescription: modelFilm.overview,
            posterURL: posterPath,
            cast: modelCast
        ) {
            [weak self] in
            guard let self = self else { return }
            
            if self.cinemaType == .films {
                self.apiClient.goTheCinemaSite(cinemaId: modelFilm.id)
            } else {
                self.apiClient.goTheTvShowSite(cinemaId: modelFilm.id)
            }
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}

extension SecondViewController {
    
    private func dateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let thisDate = dateFormatter.string(from: date!)
        let first = String(thisDate.prefix(1)).capitalized
        let other = String(thisDate.dropFirst())
        return first+other
    }
}
