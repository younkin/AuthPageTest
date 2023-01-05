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
    
    
    
    func login(mail: String, password: String, completion: @escaping (Response) -> Void) {
        coreDataProvider.loginCheck(mail: mail, password: password) { response in
            completion(response)
        }
    }
    
}
