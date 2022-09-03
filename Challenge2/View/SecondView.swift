import UIKit

class SecondView: UIView {
    
    private let idCollectionView = "idCollectionView"
    private let nameFilm: String
    private let year: String
    private let genres: String
    private let runtime: String
    private let getStarsRating: Double
    private let filmDescription: String
    private let idOfCinema: Int = 610150
    
    
//        private lazy var shadowView: UIView = {
//           let view = UIView()
//            view.backgroundColor = .black
//            view.layer.shadowColor = UIColor.red.cgColor
//            view.layer.shadowOffset = CGSize(width: 0, height: 0)
//            view.layer.shadowRadius = 200
//            view.layer.shadowOpacity = 1
//            view.layer.borderWidth = 1
//            view.layer.borderColor = UIColor.blue.cgColor
//            view.translatesAutoresizingMaskIntoConstraints = false
//            return view
//        }()
    
    
    private lazy var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "samplePoster")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    private lazy var nameFilmLabel: UILabel = {
        let label = UILabel()
        label.text = self.nameFilm
        label.textColor = .white
        label.font = .systemFont(ofSize: 52, weight: .bold)

        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.year), \(self.genres), \(self.runtime)"
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()
    
    ///Создаем массив с 5 звездочками
    private lazy var starsImageViews: [UIImageView] = {
        var images = [UIImageView]()
        for image in (1...5) {
            images.append(self.makeStars())
        }
        
        if self.getStarsRating >= 2 {
            images[0].tintColor = .yellow
        }
        if self.getStarsRating >= 4 {
            images[1].tintColor = .yellow
        }
        if self.getStarsRating >= 6 {
            images[2].tintColor = .yellow
        }
        if self.getStarsRating >= 8 {
        images[3].tintColor = .yellow
        }
        if self.getStarsRating == 10 {
        images[4].tintColor = .yellow
        }
        return images
    }()
    ///Создаем стек с 5 звездочками
    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.starsImageViews)
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.text = self.filmDescription

        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.nameFilmLabel,
            self.genreLabel,
            self.starsStackView,
            self.descriptionLabel
        ])
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10.0
        
        return sv
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Актёрский состав:"
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left

        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: self.idCollectionView)
        
        return collectionView
    }()
    
    private lazy var watchNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.watchNowButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        return button
    }()
    
    private lazy var lastStakView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [
            self.castLabel,
            self.collectionView,
            self.watchNowButton
        ])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10.0
        
        return sv
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.filmImageView,
            self.textStackView,
            self.lastStakView
        ])
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.contentStackView)
        
        return container
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    init(nameFilm: String,
         year: String,
         genres: String,
         runtime: String,
         vote_average: Double,
         filmDescription: String) {
        
        self.nameFilm = nameFilm
        self.year = year
        self.genres = genres
        self.runtime = runtime
        self.getStarsRating = vote_average
        self.filmDescription = filmDescription
        
        super.init(frame: .zero)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func watchNowButtonTapped() {
        // если фильм
        UIApplication.shared.open(URL(string: "https://www.themoviedb.org/movie/" + "\(idOfCinema)")! as URL, options: [:], completionHandler: nil)
        
        // если сериал
        // UIApplication.shared.open(URL(string: "https://www.themoviedb.org/tv" + "\(id)")! as URL, options: [:], completionHandler: nil)
    }
    
    private func setupViews() {
        self.backgroundColor = .black
        self.addSubview(self.contentScrollView)
        
        self.contentScrollView.addSubview(self.contentView)
        self.contentView.pin(to: self.contentScrollView)
        self.contentStackView.pin(to: self.contentView)
        
        NSLayoutConstraint.activate([
            
            self.contentScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.contentScrollView.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor),
            self.contentScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.contentScrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20),
            self.castLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20),
            self.collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.collectionView.heightAnchor.constraint(equalToConstant: 130),
            
            self.filmImageView.bottomAnchor.constraint(equalTo: self.textStackView.topAnchor, constant: 20.0),
            ])
    }
}

extension SecondView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height,
               height: collectionView.frame.height)
    }
}

extension SecondView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as! DetailCollectionViewCell
        return cell
    }
}

private extension SecondView {
    
    func makeStars() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .gray
        
        imageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        return imageView
    }
}
