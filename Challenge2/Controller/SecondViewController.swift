import UIKit

class SecondViewController: UIViewController {
    
    let secondView = SecondView(nameFilm: "Довод",
                                year: "2020",
                                genres: "Драма",
                                runtime: "2 часа 30 минут",
                                vote_average: 8.6,
                                filmDescription: "члопаловрпловымоятчмтядлстж]яьдьс")
    
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
        
        self.view = self.secondView
        self.setupNavigationBar()
        
        self.navigationItem.rightBarButtonItem = self.bookmarkButton

        self.navigationItem.leftBarButtonItem = self.closeButton
    }
        
    @objc private func bookmarkButtonTapped() {
        print("bookmarkButtonTapped")
    }
    
    @objc func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
}


