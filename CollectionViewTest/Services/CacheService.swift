

import Foundation
import UIKit

class CacheService {
    lazy var cacheDataSource: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        
        return cache
    }()
}
