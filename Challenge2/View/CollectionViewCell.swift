//
//  CollectionViewCell.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var posterView: UIImageView = {
        let poster = UIImageView()
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 16
        poster.sizeToFit()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "default"
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .black
        date.font = .systemFont(ofSize: 16, weight: .regular)
        date.text = "Default"
        date.textColor = .lightGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupView()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(posterView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 27),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func setupCell(title: String, release_Date: String, poster: String) {
        
        self.nameLabel.text = title
        self.dateLabel.text = release_Date
        
        // Заглушка2 Сделать загрузку фото
        
        posterView.image = UIImage (named: "samplePoster.jpg")
    }
}
