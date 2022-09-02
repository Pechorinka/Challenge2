
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
    }

//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
//    }
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
