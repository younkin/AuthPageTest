//
//  DefaultsManager.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 05.01.23.
//

import Foundation

final class DefaultsManager {
    
    @UDStorage(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool

}
