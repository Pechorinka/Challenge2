
import UIKit
import SkeletonView

class FavorireCell: FilmCell {
    var favoriteFilmsArray = [FavoriteMovieData]()
}

class FilmCell: UITableViewCell {
    var onFilmTap: ((CinemaType, Int) -> Void)?
    
    var cinemaType: CinemaType = .films
    var favoriteItemsTypes = [CinemaType]()
    
    var filmsArray = [CinemaData]() {
        didSet {
            self.filmCollection.reloadData()
        }
    }

    public lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Default"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    } ()
    
    private let apiConstructor = FilmsAPIConstructor()
    
    private lazy var filmCollection: UICollectionView = {
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
        self.contentView.backgroundColor = .black
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.filmCollection)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.headerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.headerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.filmCollection.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 0),
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
        self.sideInset
    }
}

extension FilmCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filmsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let film = self.filmsArray[indexPath.row]

   //     self.isSkeletonable = true
   //     self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(5))

        let posterPath = self.apiConstructor.getImageURL(with: film.poster_path)
        
        cell.setupCell(
            title: (film.title ?? film.name) ?? "Error",
            release_Date: (film.release_date ?? film.first_air_date) ?? "2000",
            posterURL: posterPath
        )
    //    self.stopSkeletonAnimation()
     //   self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(5))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filmID = self.filmsArray[indexPath.row].id
        
        let type: CinemaType = {
            guard self.favoriteItemsTypes.indices.contains(indexPath.row) else { return self.cinemaType }
            return self.favoriteItemsTypes[indexPath.row]
        }()

        self.onFilmTap?(type, filmID)
    }
}
