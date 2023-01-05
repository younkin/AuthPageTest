//
//  RegisterViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import Foundation


class RegisterViewModel {
    
    var coreDataProvider = CoreDataProvider()
    
    func createUser(mail:String, password:String, repPassword:String, complition:@escaping (Response) -> Void) {
        
        coreDataProvider.addNewUser(email: mail, password: password) { response in
            complition(response)
        }
        
    }
    
    
}
