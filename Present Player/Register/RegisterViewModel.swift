//
//  RegisterViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


protocol RegisterViewModelInterface {
    func createUser(mail:String, password:String, repPassword:String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void)
}

enum RegisterViewModelError: Error {
    case unknown
    case passwordReplicaIncorrect
    case createError
    case userNotExist
    case networkError
}

final class RegisterViewModel: RegisterViewModelInterface {
    
    private var authManager = AuthManager()
    
    
        func createUser(mail:String, password:String, repPassword:String, completion: @escaping (Result<Void, RegisterViewModelError>) -> Void) {
            guard password == repPassword else {
                completion(.failure(.passwordReplicaIncorrect))
                return
            }
            authManager.addNewUser(email: mail, password: password) { response in
                switch response {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    switch error {
                    case .duplicateUser:
                        completion(.failure(.createError))
                    case .userNotExist:
                        completion(.failure(.userNotExist))
                    case .networkError:
                        completion(.failure(.networkError))
                    default:
                        completion(.failure(.unknown))
                    }
                }
            }
        }


    
    
}
