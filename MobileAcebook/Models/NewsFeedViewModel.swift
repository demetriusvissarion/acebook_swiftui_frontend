//
//  NewsFeedViewModel.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let postService: PostServiceProtocol
    private let userService = UserService()
    
    // Initialize with a PostServiceProtocol to allow for dependency injection and easier testing
    public init(postService: PostServiceProtocol = PostService()) {
        self.postService = postService
    }
    
    func fetchPosts() {
        postService.fetchPosts { [weak self] posts, error in
            DispatchQueue.main.async {
                if let posts = posts {
                    self?.posts = posts
                    // Now that posts is safely unwrapped, iterate over it
                    posts.forEach { post in
                        self?.fetchUserDetails(for: post)
                    }
                } else if let error = error {
                    // Log the error or update the UI to reflect the failure
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchUserDetails(for post: Post) {
        userService.fetchUserById(userId: post.createdBy) { [weak self] userData, error in
            DispatchQueue.main.async {
                guard let self = self, let userData = userData else {
                    // Handle error or do nothing if self is nil
                    return
                }
                
                // Find the index of the post to update
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    var updatedPost = post
                    let user = User(username: userData.username, email: "", password: "", avatar: userData.avatar ?? "https://pbs.twimg.com/media/BtFUrp6CEAEmsml.jpg:large")
                    // Assuming Post has been updated to include an optional User property
                    updatedPost.user = user
                    
                    // Safely update the posts array
                    self.posts[index] = updatedPost
                }
            }
        }
    }

}


