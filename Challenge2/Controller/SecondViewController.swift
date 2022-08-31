//
//  ViewController.swift
//  HomeCinemaChelange
//
//  Created by Вячеслав Терентьев on 28.08.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentsSize
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -30)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .black
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
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "2020, Фантастика, Боевик, 2 ч 30 мин"
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let thirdStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fourthStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fithStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var contentsSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    var getRaitingStars = 7
    
    private let idCollectionView = "idCollectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        setStars()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(filmImageView)
        contentView.addSubview(shadowView)
        contentView.addSubview(nameFilmLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(watchNowButton)
        contentView.addSubview(collectionView)
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(genreLabel)
        contentView.addSubview(closeButton)
        
        stackView.addArrangedSubview(firstStarImageView)
        stackView.addArrangedSubview(secondStarImageView)
        stackView.addArrangedSubview(thirdStarImageView)
        stackView.addArrangedSubview(fourthStarImageView)
        stackView.addArrangedSubview(fithStarImageView)
        contentView.addSubview(stackView)
        
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func watchNowButtonTapped() {
        print("Watch Now")
    }
    
    @objc private func bookmarkButtonTapped() {
        print("bookmarkButtonTapped")
    }
    
    private func setStars() {
        
        let firstRange = 7...10
        let secondRange = 5...7
        let thirdRange = 4...5
        let fourthRange = 3...4
        let fithRange = 1...3
        
        if firstRange ~= getRaitingStars {
            firstStarImageView.tintColor = .systemYellow
            secondStarImageView.tintColor = .systemYellow
            thirdStarImageView.tintColor = .systemYellow
            fourthStarImageView.tintColor = .systemYellow
            fithStarImageView.tintColor = .systemYellow
        } else if secondRange ~= getRaitingStars {
            firstStarImageView.tintColor = .systemYellow
            secondStarImageView.tintColor = .systemYellow
            thirdStarImageView.tintColor = .systemYellow
            fourthStarImageView.tintColor = .systemYellow
        } else if thirdRange ~= getRaitingStars {
            firstStarImageView.tintColor = .systemYellow
            secondStarImageView.tintColor = .systemYellow
            thirdStarImageView.tintColor = .systemYellow
        } else if fourthRange ~= getRaitingStars {
            firstStarImageView.tintColor = .systemYellow
            secondStarImageView.tintColor = .systemYellow
        } else if fithRange ~= getRaitingStars {
            firstStarImageView.tintColor = .systemYellow
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
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
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -100),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 100),
            shadowView.bottomAnchor.constraint(equalTo: genreLabel.topAnchor, constant: 0),
            shadowView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            filmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            filmImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            filmImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bookmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 25),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameFilmLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameFilmLabel.bottomAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genreLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 5),
            genreLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            firstStarImageView.heightAnchor.constraint(equalToConstant: 20),
            firstStarImageView.widthAnchor.constraint(equalToConstant: 20),
            secondStarImageView.heightAnchor.constraint(equalToConstant: 20),
            secondStarImageView.widthAnchor.constraint(equalToConstant: 20),
            thirdStarImageView.heightAnchor.constraint(equalToConstant: 20),
            thirdStarImageView.widthAnchor.constraint(equalToConstant: 20),
            fourthStarImageView.heightAnchor.constraint(equalToConstant: 20),
            fourthStarImageView.widthAnchor.constraint(equalToConstant: 20),
            fithStarImageView.heightAnchor.constraint(equalToConstant: 20),
            fithStarImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            watchNowButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            watchNowButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            watchNowButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            watchNowButton.heightAnchor.constraint(equalToConstant: 50),
            watchNowButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
