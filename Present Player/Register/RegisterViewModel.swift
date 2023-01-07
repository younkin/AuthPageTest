//
//  RegisterViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


protocol RegisterViewModelInterface {
    func createUser(mail:String, password:String, repPassword:String, complition: @escaping (Result<Void, RegisterViewModelError>) -> Void)
}

enum RegisterViewModelError: Error {
    case unknown
}

final class RegisterViewModel: RegisterViewModelInterface {
    
    private var authManager = AuthManager()
    
    func createUser(mail:String, password:String, repPassword:String, complition: @escaping (Result<Void, RegisterViewModelError>) -> Void) {
        
        authManager.addNewUser(email: mail, password: password) { response in
            switch response {
            case .success:
                complition(.success(()))
            case .failure(let failure):
                complition(.failure(.unknown))
            }
        }
        
    }
    
    
}
