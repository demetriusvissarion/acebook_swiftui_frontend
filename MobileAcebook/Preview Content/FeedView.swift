//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Gabriela Ehrenbrink on 20/02/2024.
//
import Foundation
import SwiftUI

struct FeedView: View {
//    var user: User?
    @State private var isLoggedOut = false
    @State private var isPersonClicked = false
    @State private var isHouseClicked = false
    @State private var isDarkMode = false
    var body: some View {
        
        NavigationView {
            VStack{
                ScrollView{
                    // feed page layout design goes inside this scrollView (not outside it) so that it is visible between the upper and lower nav
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            HStack {
                                Text("What's on your mind? ")
                                    .padding()
                                Spacer()
                                Image(systemName: "plus.rectangle.on.rectangle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.green)
                                    .padding()
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 5)
                        
                        
                    }
                    
                    Text("Post 1")
                        .padding()
                    Text("Post 2")
                        .padding()
                    Text("Post 3")
                        .padding()
                    Text("Post 4")
                        .padding()
                    Text("Post 5")
                        .padding()
                    Text("Post 6")
                        .padding()
                    Text("Post 7")
                        .padding()
                    Text("Post 8")
                        .padding()
                    Text("Post 9")
                        .padding()
                    Text("Post 10") 
                        .padding()
                    
                }
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
                    NavigationLink(destination: FeedView(), isActive: $isHouseClicked) {
                        VStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(Color(UIColor(rgb: 0x316ff6)))
                            Text("Home")
                                .font(.caption)
                        }
                    }
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
}

struct FeedViewPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
