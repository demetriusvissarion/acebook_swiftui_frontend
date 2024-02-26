//
//  PostServiceProtocol.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation

protocol PostServiceProtocol {
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void)
}
