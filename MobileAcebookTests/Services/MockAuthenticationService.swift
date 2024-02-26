//
//  MockAuthenticationService.swift
//  MobileAcebookTests
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

@testable import MobileAcebook

class MockAuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (Bool, Error?) -> Void) {
        // Mocked logic for unit tests
        completion(true, nil) // placeholder for success
    }
}
