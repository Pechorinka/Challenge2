//
//  FilmCell.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import UIKit

class FilmCell: UITableViewCell {
    
    
    // Заглушка1
    var filmsCount = 5
    // Заглушка1
    var filmsArray = [FilmData(id: 1, overview: "ddd", title: "Тор", poster_path: "", poster: "samplePoster", release_date: "01.2022"), FilmData(id: 2, overview: "ddd", title: "Аватар", poster_path: "", poster: "samplePoster", release_date: "02.2022"), FilmData(id: 3, overview: "ddd", title: "Железный человек", poster_path: "", poster: "samplePoster", release_date: "03.2022"), FilmData(id: 4, overview: "ddd", title: "Супермен", poster_path: "", poster: "samplePoster", release_date: "04.2022"), FilmData(id: 5, overview: "ddd", title: "Фильм", poster_path: "", poster: "samplePoster", release_date: "05.2022")]
    
    private lazy var filmCollection: UICollectionView  = {
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
        self.contentView.addSubview(self.filmCollection)
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.filmCollection.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.filmCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.filmCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.filmCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

        ])
    }
}

extension FilmCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height)
        return CGSize(width: height/1.5, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}

extension FilmCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filmsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if self.filmsCount != 0 {
            cell.setupCell(title: filmsArray[indexPath.row].title, release_Date: filmsArray[indexPath.row].release_date, poster: filmsArray[indexPath.row].poster)
        }
        
        return cell
    }
    
}
