import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    let castImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "castActor")
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
        label.text = "Роберт Паттинсон"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Сотрудник ЦРУ"
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
        self.backgroundColor = .black
        self.addSubview(self.castImageView)
        self.addSubview(self.nameActorLabel)
        self.addSubview(self.roleLabel)
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
            self.roleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
