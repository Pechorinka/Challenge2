//
//  FirstView.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import UIKit

class FirstView: UIView {
    
    private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: self.bounds, style: .plain)
     tableView.backgroundColor = .black
     tableView.translatesAutoresizingMaskIntoConstraints = false
     tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
     tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
     tableView.register(TvShowCell.self, forCellReuseIdentifier: "TvShowCell")
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
            return cell
        
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
                cell.myLabel.text = "Фильмы"
                cell.myLabel.font = UIFont.systemFont(ofSize: 23)
            return cell
            
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
                    return cell
            
            case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
                cell.myLabel.text = "Сериалы"
                cell.myLabel.font = UIFont.systemFont(ofSize: 23)
                return cell
            
            case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TvShowCell", for: indexPath) as! TvShowCell
                return cell
            
            default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
                return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 50
            case 1: return 40
            case 2: return (self.frame.size.height - 130 - 32 - safeAreaInsets.top - safeAreaInsets.bottom)/2
            case 3: return 40
            case 4: return (self.frame.size.height - 130 - 32 - safeAreaInsets.top - safeAreaInsets.bottom)/2
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}

