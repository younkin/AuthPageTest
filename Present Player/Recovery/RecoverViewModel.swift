//
//  RecoverViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


class RecoverViewModel {
    
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
    
    
    func login(mail:String, password: String) -> Bool {
        
       let response = coreDataProvider.loginCheck(mail: mail, password: password)
        switch response {
        case .success:
            return true
        case .fail:
            return false
        case .connectionFail:
            return false
        default:
            return false
        }
       
    }
    
    
    func changePassword(mail:String, oldPassword: String, newPassword: String) -> Response {
        let response = coreDataProvider.changePassword(mail: mail, password: oldPassword, newPassword: newPassword)
        return response
    }
    
}

