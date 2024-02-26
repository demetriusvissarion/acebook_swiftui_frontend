//
//  NewsFeedView.swift
//  MobileAcebook
//
//  Created by Demetrius Vissarion on 20/02/2024.
//

import Foundation
import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var viewModel = NewsFeedViewModel()

    // State variables to track fetch status and error messages
    @State private var isFetching = false
    @State private var fetchFailed = false
    @State private var errorMessage = ""
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    @State private var isDarkMode = false
    @State private var thumbUpPressed = false
    @State private var quotePressed = false
    @State private var message = ""
    @State private var image = ""
    var postService: PostServiceProtocol
    let postServiceTwo = PostService()
    @State private var newPost = ""
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {

        NavigationView {

            ZStack {
                VStack {
                    // New post input field and button
                    Spacer()
                    HStack {
                        TextField("What's on your mind?", text: $newPost)
                        
                        Button(action: addNewPost) {
                            Image(systemName: "plus.rectangle.fill.on.rectangle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Posts display using ScrollView and LazyVStack
                    ScrollView {
                        LazyVStack(spacing: 16) { // Adjust spacing as needed
                            ForEach(viewModel.posts) { post in
                                VStack(alignment: .leading) {
                                    HStack(spacing: 10) {
                                        if let avatarUrl = post.user?.avatar, let url = URL(string: avatarUrl) {
                                            AsyncImage(url: url) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                        }
                                        
                                        Text(post.user?.username ?? "Username")
                                            .font(.headline)
                                    }
                    
                                    if let imageUrlString = post.image,
                                       let imageUrl = URL(string: imageUrlString) {
                                        AsyncImage(url: imageUrl) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        } placeholder: {
                                            // Placeholder while loading
                                            Text("")
                                        }
                                    }
                                    Text(post.message ?? "No message provided")
                                        
                                    
                                    HStack {
                                 
                                        Image(systemName: thumbUpPressed ? "hand.thumbsup.fill" : "hand.thumbsup")
                                            .foregroundColor(Color.blue)
                                            .onTapGesture {
                                                thumbUpPressed.toggle()
                                            }
                                        
                                        Spacer()
                                        
                                     
                                        Image(systemName: "quote.bubble")
                                            .foregroundColor(Color.blue)
                                            .onTapGesture {
                                                quotePressed.toggle()
                                            }
                                    }

                                        .font(.headline)
//                                    Text(post.image ?? "No image provided")
                                        .font(.subheadline)
                                    // Example of displaying the creation date
                                    Text("Posted on \(post.createdAt, formatter: dateFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    // Example of displaying likes and comments count
                                    HStack {
                                        Text("\(post.likes.count) Likes")
                                        Spacer()
                                        Text("\(post.comments) Comments")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                }
                                .padding()
                                .background(isDarkMode ? Color.black.opacity(1) : Color.white) // Use .white for pure white
                                .cornerRadius(10)
                                .shadow(radius: 1) // Optional: adds a subtle shadow around each post
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .background(Color.gray.opacity(0.1))
                    }
                    .onAppear {
                        viewModel.fetchPosts()
                    }
                }

                // Conditionally display messages or errors
                if isFetching {
                    ProgressView("Fetching posts...")
                } else if fetchFailed {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if viewModel.posts.isEmpty {
                    // No posts fetched
                    Text("No posts available.")
                }
            }
            .onAppear {
                fetchPosts()
            }
            .background(Color(UIColor.systemBackground))
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading:
                        Image("facebook-name-logo")
                                .resizable()
                                .frame(width: 140, height: 30)
                                .foregroundColor(isDarkMode ? .white : .black)
                    )
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.gray.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                
                                Button(action: {isDarkMode.toggle()}) {
                                    Image(systemName: isDarkMode ? "sun.max.fill" : "sun.max")
                                        .foregroundColor(isDarkMode ? Color.white : Color.black)
                                }
                            }
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.gray.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                
                                NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoggedOut) {
                                    Button(action: {
//                                        AuthenticationService().logout()
                                        isLoggedOut = true
                                    }) {
                                        Image(systemName: isLoggedOut ? "rectangle.portrait.and.arrow.right.fill" : "rectangle.portrait.and.arrow.right")
                                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                                    }
                                }
                            }
                        }

                    }
                    .environment(\.colorScheme, isDarkMode ? .dark : .light)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
//                                NavigationLink(destination: NewsFeedView(postService: PostService()), isActive: $isHouseClicked) {
                                VStack {
                                    Image(systemName: "house.fill")
                                        .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                                    Text("Home")
                                        .font(.caption)
                                }
//                                }
                            Spacer()
                            VStack {
                                Image(systemName: "play.tv")
                                    .foregroundColor(Color.gray)
                                Text("Video")
                                    .font(.caption)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "person.2")
                                    .foregroundColor(Color.gray)
                                Text("Friends")
                                    .font(.caption)
                            }
                            Spacer()
                            NavigationLink(destination: ProfileView(), isActive: $isPersonClicked) {
                                VStack {
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(Color.gray)
                                    Text("Profile")
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                }
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "bell")
                                    .foregroundColor(Color.gray)
                                Text("Notifs")
                                    .font(.caption)
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(Color.gray)
                                Text("Menu")
                                    .font(.caption)
                            }
                        }
                    }

                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        
    }

    private func fetchPosts() {
        isFetching = true
        fetchFailed = false
        errorMessage = ""

        postService.fetchPosts { posts, error in
            DispatchQueue.main.async {
                self.isFetching = false

                if let error = error {
                    self.fetchFailed = true
                    self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
                } else if let posts = posts, !posts.isEmpty {
                    self.viewModel.posts = posts
                } else {
                    // No error but also no posts
                    self.fetchFailed = true
                    self.errorMessage = "No posts found."
                }
            }
        }
    }
    
    private func addNewPost() {
        guard !newPost.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        newPost = ""
    }
}

struct NewsFeedViewPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(postService: PostService())
    }
}

