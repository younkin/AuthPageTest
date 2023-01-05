//
//  DefaultsManager.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 05.01.23.
//

import Foundation

final class DefaultsManager {
    
    @UDStorage(key: "authToken", defaultValue: "")
    static var isLogged: String

}
