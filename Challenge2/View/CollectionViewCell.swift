
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
        self.setupView()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.contentView.addSubview(self.posterView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.dateLabel)
        
        NSLayoutConstraint.activate([
            
            self.posterView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.posterView.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 27),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func setupCell(title: String, release_Date: String, poster: String) {
        
        self.nameLabel.text = title
        self.dateLabel.text = release_Date
        
        // Заглушка2 Сделать загрузку фото
        
        self.posterView.image = UIImage (named: "samplePoster.jpg")
    }
}
