
import UIKit

class FirstViewController: UIViewController {
    
    private let firstView = FirstView()
    let apiClient = FilmsAPIClient()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.firstView)
        self.firstView.translatesAutoresizingMaskIntoConstraints = false
        self.firstView.backgroundColor = .black
        self.setupConstraints()
        
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

    func setupConstraints () {
        NSLayoutConstraint.activate([
            self.firstView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.firstView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.firstView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.firstView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
