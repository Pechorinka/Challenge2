
import UIKit

class FirstView: UIView {
    
    var toNextVC: ((FilmsTableSection, Int) -> Void)?
    var filmsArray = [CinemaData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var tvShowsArray = [CinemaData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var favoriteFilmsArray = [CinemaData]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    } ()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.overrideUserInterfaceStyle = .light
        addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
}

enum FilmsTableSection: Int {
    case popularMovie
    case tvShos
    case favourites
    
    var title: String {
        switch self {
        case .popularMovie:
            return "Popular Movie"
        case .tvShos:
            return "TV Show"
        case .favourites:
            return "Favourites"
        }
    }
    
}

extension FirstView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.makeFilmCell(for: indexPath, tableView: tableView)
    }
    
    func makeFilmCell(for indexPath: IndexPath, tableView: UITableView) -> FilmCell {
        let section = FilmsTableSection(rawValue: indexPath.section)!
        
        let films: [CinemaData] = {
            switch section {
            case .popularMovie:
                return self.filmsArray
            case .tvShos:
                return self.tvShowsArray
            case .favourites:
                return self.favoriteFilmsArray
            }
        }()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        cell.filmsArray = films
        cell.cinemaType = section
        cell.headerLabel.text = section.title
        cell.onFilmTap = {
            [weak self] type, filmID in
            self?.toNextVC?(type, filmID)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if filmsArray.count == 0 {
             switch indexPath.section {
             case 0: return (self.frame.size.height)/2.5
             case 1: return (self.frame.size.height)/2.8
             default: return 0
            }
        } else {
            switch indexPath.section {
            case 0: return (self.frame.size.height)/2.5
            case 1: return (self.frame.size.height)/2.8
            case 2: return (self.frame.size.height)/3
              default: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filmsArray.count == 0 {
        return 2
        } else { return 3 }
    }
}

