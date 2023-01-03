//
//  AuthViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import Foundation
import UIKit

class AuthViewModel {
    
    
    var coreDataProvider = CoreDataProvider()
    
    init(){
        
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
        }
       
    }
    
  
    
    
}
