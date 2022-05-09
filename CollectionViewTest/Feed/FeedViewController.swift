

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService()
    private let cacheService = CacheService()
    
    private lazy var customView = view as! FeedView
    private let refreshControl = UIRefreshControl()
    
    private var photo = UIImage()
    private var cellCount = 6
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = FeedView()
        self.title = "Photo"
        customView.collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        customView.collectionView.alwaysBounceVertical = true
        customView.collectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh() {
        cellCount = 6
        customView.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier, for: indexPath) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = cacheService.cacheDataSource.object(forKey: indexPath.row as AnyObject) {
            cell.configure(photo: image)
        } else {
            networkService.getPhotos { [weak self] image in
                guard let unwrappedImage = image else { return }
                
                cell.configure(photo: unwrappedImage)
                collectionView.reloadItems(at: [indexPath])
                
                self?.cacheService.cacheDataSource.setObject(unwrappedImage, forKey: indexPath.row as AnyObject)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.5, animations: {
            cell?.frame.origin.x = self.view.bounds.width
        }) { _ in
            
            self.cellCount -= 1
            cell?.alpha = 0
            collectionView.deleteItems(at: [indexPath])
        }
        
    }
}
