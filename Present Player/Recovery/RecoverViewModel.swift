//
//  RecoverViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation

protocol RecoverViewModelInterface {
//    func createUser(mail: String, password: String, repPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void)
    func changePassword(mail:String, oldPassword: String, newPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void)
    func inputDataCheck (email:String, password: String, repPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) -> Bool
    func retry()
}

enum RecoverViewModelError: Error {
    case createError
    case wrongCredentials
    case unknown
    case emailSpellingMistake
    case passwordSpellingMistake
    case userNotExist
    case networkError
}

final class RecoverViewModel: RecoverViewModelInterface {
   
    
    
    var authManager = AuthManager()
    private var lastAction: (() -> (Void))?

    func retry() {
        lastAction?()
    }
    
    func inputDataCheck (email:String, password: String, repPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) -> Bool {
        guard email.isValidEmail() else {
            completion(.failure(.emailSpellingMistake))
            return false
        }
        guard password.isValidPassword(),
           repPassword.isValidPassword() else {
            completion(.failure(.passwordSpellingMistake))
            return false
        }
        completion(.success(()))
        return true
    }
 
    
   
    
    func changePassword(mail:String, oldPassword: String, newPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) {
        let action: (() -> (Void))? = { [weak authManager] in
            authManager?.changePassword(mail: mail, password: oldPassword, newPassword: newPassword) { response in
                switch response {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    switch error {
                    case .wrongPassword:
                        completion(.failure(.wrongCredentials))
                    case.userNotExist:
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
  
    
}

