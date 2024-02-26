//
//  Post.swift
//  MobileAcebook
//

import Foundation

public struct Post: Hashable, Codable, Identifiable {
    public let id: String
    let message: String?
    let image: String?
    let createdBy: String // Retained for user detail fetching
    let createdAt: Date
    let likes: [String]
    let comments: Int
    var user: User? // Optional User property to store associated user details

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message, image, createdBy, createdAt, likes, comments
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        createdBy = try container.decode(String.self, forKey: .createdBy)

        // Decode createdAt as String then convert to Date
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        guard let date = DateFormatter.postDateFormatter.date(from: createdAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        createdAt = date

        likes = try container.decode([String].self, forKey: .likes)
        comments = try container.decode(Int.self, forKey: .comments)
        user = nil // User will be set separately after fetching post details
    }
    
    // Custom initializer to manually create Post instances if needed
    init(id: String, message: String?, image: String?, createdBy: String, createdAt: Date, likes: [String], comments: Int, user: User? = nil) {
        self.id = id
        self.message = message
        self.image = image
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.likes = likes
        self.comments = comments
        self.user = user
    }
}

extension DateFormatter {
    static let postDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}


