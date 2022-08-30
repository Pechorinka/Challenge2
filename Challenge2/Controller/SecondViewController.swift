//
//  SecondViewController.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 28.08.2022.
//

import UIKit

class SecondViewController: UIViewController {
    var networkManager = NetworkManager()
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.contentSize = contentsSize
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let contentView = UIView()
        contentView.backgroundColor = .none
        contentView.frame.size = contentsSize
        return contentView
    }()
    
    private let filmImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "tenet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameFilmLabel: UILabel = {
       let label = UILabel()
        label.text = "Довод"
        label.textColor = .white
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.text = "После теракта в киевском оперном театре агент ЦРУ объединяется с британской разведкой, чтобы противостоять русскому олигарху, который сколотил состояние на торговле оружием. Для этого агенты используют инверсию времени — технологию будущего, позволяющую времени идти вспять."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let castLabel: UILabel = {
       let label = UILabel()
        label.text = "Актёрский состав:"
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var watchNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(watchNowButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var contentsSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 300)
    }
    
    private let idCollectionView = "idCollectionView"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(filmImageView)
        contentView.addSubview(nameFilmLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(watchNowButton)
        contentView.addSubview(collectionView)
        
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func watchNowButtonTapped() {
        print("Watch Now")
    }
}

//MARK: - UICollectionViewDataSource

extension SecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as! DetailCollectionViewCell
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height,
               height: collectionView.frame.height)
    }
}

//MARK: - SetConstraints

extension SecondViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            filmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            filmImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            filmImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            nameFilmLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameFilmLabel.bottomAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            watchNowButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            watchNowButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            watchNowButton.heightAnchor.constraint(equalToConstant: 50),
            watchNowButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 180),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5)
        ])
    }
}
