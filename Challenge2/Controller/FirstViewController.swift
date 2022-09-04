
import UIKit

class FirstViewController: UIViewController {
    
    private let firstView = FirstView()
    let apiClient = FilmsAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.firstView
        navigationItem.title = "WOWTeam"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.setupNavigationBar()
        
        self.apiClient.getPopularMovie {
            [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movies):
                self.firstView.filmsArray = movies
            case .failure(let error):
                print(error)
            }
        }

        self.apiClient.getPopularTvShow {
            [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movies):
                self.firstView.tvShowsArray = movies
            case .failure(let error):
                print(error)
            }
        }
        
        firstView.toNextVC = {
            [weak self] type, filmID in
            guard let self = self else { return }
            
            switch type {
                
            case .popularMovie, .tvShos:
                let nextVC = SecondViewController()
                nextVC.cinemaType = .init(filmsTableSection: type)!
                nextVC.filmID = filmID
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            case .favourites:
                break
                
            }
            
        }
    }
}

extension CinemaType {
    init?(filmsTableSection: FilmsTableSection) {
        switch filmsTableSection {
        case .popularMovie:
            self = .films
        case .tvShos:
            self = .tvShows
        case .favourites:
            return nil
        }
    }
}

extension UIViewController {
    
    func setupNavigationBar() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.editButtonItem.tintColor = .white
        navigationController?.navigationBar.standardAppearance = coloredAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
        navigationController?.navigationBar.tintColor = .clear
    }
    
}
