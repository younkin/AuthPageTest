//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData

class AuthViewController: UIViewController {
    
    var authViewModel = AuthViewModel()
    private lazy var customView = self.view as? AuthView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
      
        
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = AuthView()
        self.view = view
    }
    
}
