//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    @State private var isSignupViewPresented = false
    let authService = AuthenticationService()
    let postService = PostService()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()

                    Text("Welcome to Acebook!")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")

                    Spacer()

                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()

                    
                    NavigationLink(
                        destination: SignupView(authenticationService: authService),
                        label: {
                            Text("Sign Up")
                        }
                    )
                    .accessibilityIdentifier("signUpButton")
                    
                    NavigationLink(
                        destination: NewsFeedView(postService: postService),
                        label: {
                            Text("News Feed")
                        }
                    )
                    .accessibilityIdentifier("newsFeedButton")
                    
                    Spacer()
                }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
