//
//  RecoverViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


class RecoverViewModel {
    
    var coreDataProvider = CoreDataProvider()
    
    
    func createUser(mail:String, password:String, repPassword:String, complition:@escaping (Response) -> Void) {
        coreDataProvider.addNewUser(email: mail, password: password) { response in
            complition(response)
        }
    }
    
    
    func login(mail: String, password: String, completion: @escaping (Response) -> Void) {
        coreDataProvider.loginCheck(mail: mail, password: password) { response in
            completion(response)
        }
    }
    
    func changePassword(mail:String, oldPassword: String, newPassword: String, complition: @escaping (Response) -> Void) {
        coreDataProvider.changePassword(mail: mail, password: oldPassword, newPassword: newPassword) { response
            in
            complition(response)
        }
    }
    
}

