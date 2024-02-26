


import Foundation
import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var usernameRequired = false
    @State private var email = ""
    @State private var emailRequired = false
    @State private var isEmailValid = false
    @State private var password = ""
    @State private var passwordRequired = false
    @State private var isPasswordValid = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSignupSuccessful = false
    @State private var shouldNavigate2 = false
    @State private var isSignupInProgress = false
    var iconClick = true
    
    var authenticationService: AuthenticationServiceProtocol
    let authService = AuthenticationService()
    
    var body: some View {
        
            VStack {
                
                Spacer()
                Text("Acebook")
                    .font(.system(size: 80))
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                    .bold()
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 330, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: username, perform: { value in
                        usernameRequired = !username.isEmpty
                    })
                
                TextField("Email address", text: $email)
                    .padding()
                    .frame(width: 330, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .onChange(of: email, perform: { value in
                        emailRequired = !email.isEmpty
//                        isEmailValid = isValidEmail(email)
                    })


                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 330, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .onChange(of: password, perform: { value in
                        passwordRequired = !password.isEmpty
                        isPasswordValid = isValidPassword(password)
                    })
                
                if isPasswordValid {
                    Text("Password valid")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    signup()
                }) {
                    Text("Sign Up")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(rgb: 0x38548f)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isSignupInProgress) // Disable the button while sign-up is in progress
                .padding()
                
            Spacer()

                HStack {
                    Text("Already have an account? Login")
                        .foregroundColor(.white)
                    NavigationLink(
                        destination: LoginPage(authenticationService: AuthenticationService()),
                        isActive: $shouldNavigate2,
                        label: {
                            Text("HERE")
                                .foregroundColor(.white)
                                .underline(true, color: .white)
                                .onTapGesture {
                                    shouldNavigate2 = true}
                        }
                    )
                }
            }
            
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .background(Color(UIColor(rgb: 0x4267B2)))
}
    
    private func signup() {
            let newUser = User(username: username, email: email, password: password)

            // Set isSignupInProgress to true when sign-up begins
            isSignupInProgress = true

            authenticationService.signUp(user: newUser) { success, error in
                DispatchQueue.main.async {
                    // Reset isSignupInProgress when sign-up completes
                    defer { isSignupInProgress = false }
                    print("Signup callback: success = \(success), error = \(error?.localizedDescription ?? "nil")")

                    if success {
                        print("Signup successful")
                        alertMessage = "Signup successful"

                        // Update isSignupSuccessful to trigger the NavigationLink
                        isSignupSuccessful = true
                    } else {
                        print("Signup failed: \(error?.localizedDescription ?? "Unknown error")")
                        alertMessage = "Signup failed: \(error?.localizedDescription ?? "Unknown error")"
                    }
                    showAlert = true
                }
            }
        }

    private func isValidPassword(_ password: String) -> Bool {
        let psswordRegex = "^(?=.*[!@£$%^&*.,])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", psswordRegex).evaluate(with: password)
    }
    

}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

struct SignupViewPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(authenticationService: AuthenticationService())
    }
}
