import UIKit
import Kingfisher

class DetailCollectionViewCell: UICollectionViewCell {
    
    private lazy var castImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.cornerRadius = 45
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameActorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray

        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .black
        self.contentView.addSubview(self.castImageView)
        self.contentView.addSubview(self.nameActorLabel)
        self.contentView.addSubview(self.roleLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            self.castImageView.heightAnchor.constraint(equalToConstant: 90),
            self.castImageView.widthAnchor.constraint(equalToConstant: 90),
            self.castImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.nameActorLabel.topAnchor.constraint(equalTo: self.castImageView.bottomAnchor, constant: 3),
            self.nameActorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.roleLabel.topAnchor.constraint(equalTo: self.nameActorLabel.bottomAnchor, constant: 3),
            self.roleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            self.roleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
        ])
    }
    
    func setupCell(nameActorLabel: String, roleLabel: String, posterURL: URL?) {
        self.nameActorLabel.text = nameActorLabel
        self.roleLabel.text = roleLabel
        self.castImageView.kf.setImage(with: posterURL, placeholder: UIImage(named: "no-photo"))
    }
}
