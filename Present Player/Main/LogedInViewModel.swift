//
//  LogedInViewModel.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 07.01.23.
//

import Foundation


protocol LogedInViewModelInterface {
    func logout()
}

enum LogedInViewModelError: Error {
    case unknown
}

final class LogedInViewModel: LogedInViewModelInterface {
    
    private var authManager = AuthManager()
    
    func logout() {
        DefaultsManager.isLoggedIn = false
    }
    
}
