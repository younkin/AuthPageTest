//
//  AuthViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import Foundation
import UIKit


protocol AuthViewModelInterface {
    func login(mail: String, password: String, completion: @escaping (Result<Void, AuthViewModelError>) -> Void)
    func inputDataCheck (email:String, password: String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) -> Bool
    func retry()
}

enum AuthViewModelError: Error {
    case wrongCredentials
    case connectionLost
    case unknown
}

final class AuthViewModel: AuthViewModelInterface {
    
    private var authManager = AuthManager()
    private var lastAction: (() -> (Void))?
    
    
    func inputDataCheck (email:String, password: String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) -> Bool {
        guard email.isValidEmail() else {
            completion(.failure(.emailSpellingMistake))
            return false
        }
        guard password.isValidPassword() else {
            completion(.failure(.passwordSpellingMistake))
            return false
        }
     
        completion(.success(()))
        return true
    }
    
    func login(mail: String, password: String, completion: @escaping (Result<Void, AuthViewModelError>) -> Void) {
        let action: (() -> (Void))? = { [weak authManager] in
            authManager?.authorize(mail: mail, password: password) { response in
                switch response {
                case .success:
                    DefaultsManager.isLoggedIn = true
                    completion(.success(()))
                case .failure(let error):
                    switch error {
                    case .loginFailed:
                        completion(.failure(.wrongCredentials))
                    default:
                        completion(.failure(.unknown))
                    }
                }
            }
        }
        lastAction = action
        action?()
    }
    
    func retry() {
        lastAction?()
    }
    
}
