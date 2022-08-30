//
//  TvShowCell.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import UIKit

class TvShowCell: UITableViewCell {
    
    
    // Заглушка1
    var tvShowCount = 4
    // Заглушка1
    var tvShowArray = [TvShowData(id: 1, name: "Во все тяжкие", poster_path: "", poster: "samplePoster", release_date: "1.2022"), TvShowData(id: 2, name: "Друзья", poster_path: "", poster: "samplePoster", release_date: "2.2022"), TvShowData(id: 3, name: "Игры престолов", poster_path: "", poster: "samplePoster", release_date: "3.2022"), TvShowData(id: 4, name: "Зеркало", poster_path: "", poster: "samplePoster", release_date: "4.2022")]
    
    private lazy var tvShowCollection: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
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
        self.contentView.addSubview(self.tvShowCollection)
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.tvShowCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.tvShowCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.tvShowCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.tvShowCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

        ])
    }
}

extension TvShowCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height)
        return CGSize(width: height/1.5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}

extension TvShowCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.tvShowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if self.tvShowCount != 0 {
            cell.setupCell(title: tvShowArray[indexPath.row].name, release_Date: tvShowArray[indexPath.row].release_date, poster: tvShowArray[indexPath.row].poster)
        }
        
        return cell
    }
    
}
