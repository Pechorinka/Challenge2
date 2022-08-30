
import UIKit

class FirstView: UIView {
    
    var favouritesCount = 2
    
    var favouritesArray = [CinemaData(poster_path: "", id: 100, title: "Первый", name: "Первый", release_date: "22/00/2020", first_air_date: "22/01/2022"), CinemaData(poster_path: "", id: 120, title: "Второй", name: "Втоорой", release_date: "21/00/2020", first_air_date: "21/01/2022")]
    
    
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
        tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.myLabel.text = "WOWTeam"
            cell.myLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.myLabel.text = "Фильмы"
            cell.myLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.filmsArray
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.myLabel.text = "Сериалы"
            cell.myLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.tvShowsArray
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.myLabel.text = "Избранное"
            cell.myLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
            cell.filmsArray = self.favouritesArray
            return cell
            
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if favouritesCount == 0 {
            switch indexPath.section {
            case 0: return 60
            case 1: return 50
            case 2: return (self.frame.size.height)/3.5
            case 3: return 50
            case 4: return (self.frame.size.height)/4
            default: return 0
            }
        } else {
            switch indexPath.section {
            case 0: return 60
            case 1: return 50
            case 2: return (self.frame.size.height)/3
            case 3: return 50
            case 4: return (self.frame.size.height)/4
            case 5: return 50
            case 6: return (self.frame.size.height)/5
            default: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if favouritesCount == 0 {
        return 5
        } else { return 7 }
    }
}

