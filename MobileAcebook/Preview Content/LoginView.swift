import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var isLoginSuccessful = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldNavigate = false
    
    var authenticationService: AuthenticationService
    let postService = PostService()
    
    var body: some View {
            ZStack {
                
                Color(UIColor(rgb: 0x4267B2))
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Acebook")
                        .font(.system(size: 80))
                        .bold()
                        .padding()
                        .foregroundColor(Color.white)
                    TextField("Email", text: $email)
                        .padding()
                        .autocapitalization(.none)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(.red, width:
                                    CGFloat(wrongEmail))
                        .accessibilityIdentifier("Email")
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                        .accessibilityIdentifier("Password")
                    NavigationLink(
                            destination: NewsFeedView(postService: postService),
                            isActive: $shouldNavigate
                        ) {
                            EmptyView()
                                        }
                    
                    Button(action: {
                        authenticateUser(email: email, password: password)
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color(red: Double((0x254778 & 0xFF0000) >> 16) / 255.0, green: Double((0x254778 & 0x00FF00) >> 8) / 255.0, blue: Double(0x254778 & 0x0000FF) / 255.0))
                            .cornerRadius(10)
                            .bold()
                            .accessibilityIdentifier("signInButton")
                            .padding()
                    }
                    Spacer()
                        HStack {
                            Text("Don't have an account? Create one")
                                .foregroundColor(.white)
                            NavigationLink(
                                destination: SignupView(authenticationService: AuthenticationService()),
                                label: {
                                    Text("HERE")
                                        .foregroundColor(.white)
                                        .underline(true, color: .white)
                                        
                                }
                            )
                        }
                }

                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
           

    }

    func authenticateUser(email: String, password: String) {
        authenticationService.LogIn(email: email, password: password) { success, error in
            if success {
                // Authentication succeeded, navigate to the FeedView
                print("Authentication successful!")
                shouldNavigate = true
            } else {
                // Authentication failed, show an error message
                showAlert = true
                alertMessage = "Authentication failed!"
                print("Authentication Error")
            }
        }
    }
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(authenticationService: AuthenticationService())
    }
}
