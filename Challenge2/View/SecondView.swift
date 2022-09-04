import UIKit
import Kingfisher

class SecondView: UIView {
    
    private let idCollectionView = "idCollectionView"
    
    private let apiConstructor = FilmsAPIConstructor()
    private let nameFilm: String
    private let year: String
    private let genres: [String]
    private let runtime: Double
    private let getStarsRating: Float
    private let filmDescription: String
    private let posterURL: URL?
    private let cast: ActorsData
    
    private lazy var shadowView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gradient")
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    private lazy var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.kf.setImage(with: posterURL)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addSubview(shadowView)

        return imageView
    }()
    
    private lazy var nameFilmLabel: UILabel = {
        let label = UILabel()
        label.text = self.nameFilm
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 52, weight: .bold)

        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        let genres = self.genres.joined(separator: ",")
        
        label.text = "\(self.year), \(genres), \((self.runtime * 60.0).asString(style: .short))"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center

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
        label.font = UIFont.systemFont(ofSize: 16)
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
        label.text = "Cast:"
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
         genres: [String],
         runtime: Double,
         getStarsRating: Float,
         filmDescription: String,
         posterURL: URL?,
         cast: ActorsData
    ) {
        self.nameFilm = nameFilm
        self.year = year
        self.genres = genres
        self.runtime = runtime
        self.getStarsRating = vote_average
        self.filmDescription = filmDescription
        self.posterURL = posterURL
        self.cast = cast
        
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
        self.shadowView.pin(to: self.filmImageView)
        
        
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
        self.cast.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as! DetailCollectionViewCell
        
        let cast = self.cast.cast[indexPath.row]
        
        let posterPath = self.apiConstructor.getImageURL(with: cast.profile_path ?? "")
//        
        cell.setupCell(
            nameActorLabel: cast.name,
            roleLabel: (cast.character ?? cast.roles?[0].character) ?? "",
            posterURL: posterPath)
        
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

private extension Double {
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, ]
        formatter.unitsStyle = style
        formatter.calendar?.locale = Locale(identifier: "en")
        
        return formatter.string(from: self) ?? ""
    }
}
