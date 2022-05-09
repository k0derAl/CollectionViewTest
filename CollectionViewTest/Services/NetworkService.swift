

import Foundation
import UIKit

class NetworkService {
    func getPhotos(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://dummyimage.com/800x600/000/fff.jpg&text=TEST") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("ERROR - \(error)")
            } else {
                guard let data = data else { return }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        session.resume()
    }
}
