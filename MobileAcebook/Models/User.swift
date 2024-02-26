//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

struct User: Codable, Hashable {
    let username: String
    let avatar: String?
    let email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case username, avatar, email, password
    }

    // Custom initializer if needed
    init(username: String, email: String, password: String, avatar: String = "https://pbs.twimg.com/media/BtFUrp6CEAEmsml.jpg:large") {
        self.username = username
        self.avatar = avatar
        self.email = email
        self.password = password
    }
}
