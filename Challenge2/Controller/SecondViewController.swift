import UIKit

class SecondViewController: UIViewController {
    
    let secondView = SecondView(nameFilm: "Довод",
                                year: "2020",
                                genres: "Драма",
                                runtime: "2 часа 30 минут",
                                vote_average: 8.6,
                                filmDescription: "члопаловрпловымоятчмтядлстж]яьдьс")
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.bookmarkButtonTapped)
                                     )
        button.tintColor = UIColor.red
        
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.popViewControler)
                                     )
        button.tintColor = UIColor.red
        
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


