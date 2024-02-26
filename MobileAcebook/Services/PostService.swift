import Foundation
import KeychainSwift

struct PostResponse: Codable {
    let posts: [Post]
    let user: User
    let token: String
}

class PostService: PostServiceProtocol, ObservableObject {
    
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        
        let token = getTokenFromKeychain() // temporary token only used locally, will be saved in separed gitignored file later on
        
        guard let url = URL(string: "http://127.0.0.1:8080/posts") else {
            completion(nil, nil)
            return
        }
        
        if let token = getTokenFromKeychain() {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                //             Print the raw JSON response as a string for debugging
                //            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                //                print("Raw JSON response: \(jsonString)")
                //            }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                    completion(nil, nil) // Consider creating a specific error to return here
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                        let container = try decoder.singleValueContainer()
                        let dateString = try container.decode(String.self)
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                        if let date = formatter.date(from: dateString) {
                            return date
                        }
                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(dateString)")
                    })
                    
                    let responseData = try decoder.decode(PostResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseData.posts, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }.resume()
        }
    }
}
