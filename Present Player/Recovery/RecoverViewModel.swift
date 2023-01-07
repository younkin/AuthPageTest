//
//  RecoverViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation

protocol RecoverViewModelInterface {
    func createUser(mail: String, password: String, repPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void)
    func login(mail: String, password: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void)
    func changePassword(mail:String, oldPassword: String, newPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void)
}

enum RecoverViewModelError: Error {
    case createError
    case wrongCredentials
    case unknown
    case passwordReplicaIncorrect
}

final class RecoverViewModel: RecoverViewModelInterface {
    
    var authManager = AuthManager()
    
    func inputDataCheck () {
        
    }
    
    func createUser(mail:String, password:String, repPassword:String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) {
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
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
    
    
    func login(mail: String, password: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) {
        authManager.authorize(mail: mail, password: password) { response in
            switch response {
            case .success:
                completion(.success(()))
            case .failure(let error):
                switch error {
                case .wrongPassword:
                    completion(.failure(.wrongCredentials))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
    
    func changePassword(mail:String, oldPassword: String, newPassword: String, completion: @escaping (Result<Void, RecoverViewModelError>) -> Void) {
        authManager.changePassword(mail: mail, password: oldPassword, newPassword: newPassword) { response in
            switch response {
            case .success:
                completion(.success(()))
            case .failure(let error):
                switch error {
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
    
}

