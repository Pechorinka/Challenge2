import UIKit

class SecondViewController: UIViewController {
    
    let apiClient = FilmsAPIClient()
    private let apiConstructor = FilmsAPIConstructor()
    var cinemaType: CinemaType = .films
    var filmID: Int = 0
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark", withConfiguration: config),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.bookmarkButtonTapped)
                                     )
        button.tintColor = UIColor.white

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
        print("bookmarkButtonTapped")
    }
    
    @objc func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViewWithData(_ filmInfo: FilmDescriptionData, _ castInfo: ActorsData) {
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
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
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
