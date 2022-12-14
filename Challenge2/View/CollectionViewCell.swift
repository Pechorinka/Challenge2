
import UIKit
import Kingfisher


class CollectionViewCell: UICollectionViewCell {

    public func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let thisDate = dateFormatter.string(from: date!)
        let first = String(thisDate.prefix(1)).capitalized
        let other = String(thisDate.dropFirst())
        return first+other  
    }
    
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
    
    func setupCell(title: String, release_Date: String, posterURL: URL?) {
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .black, secondaryColor: .darkGray), animation: nil, transition: .crossDissolve(1))
        
        self.nameLabel.text = title
        self.dateLabel.text = DateFromWebtoApp(release_Date)
        self.posterView.kf.setImage(with: posterURL)
        
        self.stopSkeletonAnimation()
        self.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(1))
    }
}
