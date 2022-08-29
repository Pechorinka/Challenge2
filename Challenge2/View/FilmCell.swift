//
//  FilmCell.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import UIKit

class FilmCell: UITableViewCell {
    
    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.myView)
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

        ])
    }
}

