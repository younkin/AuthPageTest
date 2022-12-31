//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var coreDataProvider = CoreDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        coreDataProvider.addNewUser(email: "123", password: "123")
        coreDataProvider.getAllUsers()
        
        print("3223")
        
    }
    
}
