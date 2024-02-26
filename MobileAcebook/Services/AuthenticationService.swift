//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation
import KeychainSwift

let keychain = KeychainSwift()

func saveTokenToKeychain(token: String) {
    keychain.set(token, forKey: "authToken")
}

func getTokenFromKeychain() -> String? {
    return keychain.get("authToken")
}


class AuthenticationService: ObservableObject, AuthenticationServiceProtocol {

    func signUp(user: User, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/")?.appendingPathComponent("users") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            request.httpBody = userData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(false, nil)
                    return
                }
                
                completion(true, nil)
            }.resume()
        } catch {
            completion(false, error)
        }

    }
    
    func LogIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/tokens") else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = [
            "email": email,
            "password": password
        ]
        
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(credentials)
            request.httpBody = userData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode([String: String].self, from: data)
                        if let token = responseObject["token"] {
                            // Save the token using Keychain
                            saveTokenToKeychain(token: token)
                            DispatchQueue.main.async {
                                completion(true, nil)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(false, nil) // Token not found in response
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(false, error)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, nil)
                    }
                }
                
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    completion(false, nil)
//                    return
//                }
                
//                // Save token to UserDefaults
//                if let responseData = data,
//                   let token = String(data: responseData, encoding: .utf8) {
//                    saveTokenToUserDefaults(token: token)
//                }
                
                completion(true, nil)
            }.resume()
        } catch {
            completion(false, error)
        }
    }
    
//    func logout() {
//           UserDefaults.standard.removeObject(forKey: "authToken")
//       }

}
//func saveTokenToUserDefaults(token: String) {
//    UserDefaults.standard.set(token, forKey: "authToken")
//}



