//
//  RegisterViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


class RegisterViewModel {
    
    var coreDataProvider = CoreDataProvider()
    
    
    func checkUserInBase(mail: String) -> Bool {
        
        let response = coreDataProvider.checkMailInBase(mail: mail)
        
        switch response {
        case .userNotExist:
            return true
        case .userExist:
            return false
        case .connectionFail:
            return false
        default:
            return false
        }
    }
    
    func createUser(mail:String, password:String, repPassword:String) -> Bool {
        let response = coreDataProvider.addNewUser(email: mail, password: password)
        return true
    }
   
    
}
