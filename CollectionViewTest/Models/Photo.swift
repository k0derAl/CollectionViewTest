
import Foundation

struct Photo: Decodable {
    let id: String
    let createdAt: String
    let likes: Int
    let urls: URLS
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case likes = "likes"
        case urls = "urls"
        case description = "description"
    }
}

struct URLS: Decodable {
    let regular: URL
}

struct PhotoResponse: Decodable {
    let results: [Photo]
}
