//
//  RegisterViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


protocol RegisterViewModelInterface {
    func createUser(mail:String, password:String, repPassword:String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void)
    func inputDataCheck (email:String, password: String, repPassword: String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) -> Bool
    func retry()
}

enum RegisterViewModelError: Error {
    case unknown
    case passwordReplicaIncorrect
    case createError
    case userNotExist
    case networkError
    case passwordSpellingMistake
    case emailSpellingMistake
    case duplicateUser
}

final class RegisterViewModel: RegisterViewModelInterface {
    
    private var authManager = AuthManager()
    
    private var lastAction: (() -> (Void))?

    func retry() {
        lastAction?()
    }
    
    func inputDataCheck (email:String, password: String, repPassword: String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) -> Bool {
        guard email.isValidEmail() else {
            completion(.failure(.emailSpellingMistake))
            return false
        }
        guard password.isValidPassword(),
           repPassword.isValidPassword() else {
            completion(.failure(.passwordSpellingMistake))
            return false
        }
        guard password == repPassword else {
            completion(.failure(.passwordReplicaIncorrect))
            return false
        }
        completion(.success(()))
        return true
    }
    
    
        func createUser(mail:String, password:String, repPassword:String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) {
            guard password == repPassword else {
                completion(.failure(.passwordReplicaIncorrect))
                return
            }
            let action: (() -> (Void))? = { [weak authManager] in
                
                authManager?.addNewUser(email: mail, password: password) { response in
                    switch response {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        switch error {
                        case .duplicateUser:
                            completion(.failure(.duplicateUser))
                        case .networkError:
                            completion(.failure(.networkError))
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
