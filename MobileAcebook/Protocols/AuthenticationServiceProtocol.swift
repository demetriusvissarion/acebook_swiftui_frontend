//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

protocol AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (Bool, Error?) -> Void)
}

