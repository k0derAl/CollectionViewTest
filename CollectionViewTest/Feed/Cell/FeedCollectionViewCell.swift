

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "feedCollectionViewCell"
    
    // MARK: - Private Properties
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(photo: UIImage) {
        
        photoImageView.image = photo
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        backgroundColor = .darkGray
        
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
