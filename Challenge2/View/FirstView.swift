
import UIKit

class FirstView: UIView {
    
    var toNextVC :(() -> Void)?
    
    var favouritesCount = 2
    
    var favouritesArray = [CinemaData(poster_path: "", id: 100, title: "Первый", name: "Первый", release_date: "2020-01-21", first_air_date: "2020-01-21"), CinemaData(poster_path: "", id: 120, title: "Второй", name: "Втоорой", release_date: "2020-01-21", first_air_date: "2020-01-21")]
    
    
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
        self.backgroundColor = .green
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

extension FirstView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.filmsArray
            cell.headerLabel.text = "Popular Movie"
            cell.nextVC = {
                self.toNextVC?()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.tvShowsArray
            cell.headerLabel.text = "TV Show"
            cell.nextVC = {
                self.toNextVC?()
            }
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.favouritesArray
            cell.headerLabel.text = "Favourites"
            cell.nextVC = {
                self.toNextVC?()
            }
            return cell
            
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if favouritesCount == 0 {
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
        if favouritesCount == 0 {
        return 2
        } else { return 3 }
    }
}

