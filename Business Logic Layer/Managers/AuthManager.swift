//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData
import Network

enum AuthError: Error {
    case duplicateUser
    case userNotExist
    case wrongPassword
    case loginFailed
    case unknown
    case networkError
}

final class AuthManager {
    
    private let monitor = NWPathMonitor()
    private var isConnectioned: Bool = false
    
    struct Constants {
        static let entity = "Person"
    }
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnectioned = true
            } else {
                self?.isConnectioned = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addNewUser(email: String, password: String, complition: @escaping (Result<Void, AuthError>) -> Void) {
        if checkMailInBase(mail:email) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(.failure(.duplicateUser))
            }
            return
        }
        
        // TODO: !!!
        let object = Person()
        object.mail = email
        object.password = password
        CoreDataProvider.instance.saveContext()
        //        let token = UUID().uuidString
//        let token = "2ed332edfrssr"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(.success(()))
        }
        
    }
    
    
    func changePassword(mail: String, password: String, newPassword: String, complition: @escaping (Result<Void, AuthError>) -> Void)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let results = try CoreDataProvider.instance.context.fetch(fetchRequest)
            guard let person = results.first as? Person else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    complition(.failure(.userNotExist))
                }
                return
            }
            guard person.password == password else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    complition(.failure(.wrongPassword))
                }
                return
            }
            person.password = newPassword
            CoreDataProvider.instance.saveContext()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(.success(()))
            }
            return
        } catch {
            print(error)
        }
        // TODO: !!!
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            complition(Response(result: .connectionFail))
//        }
    }
    
    private func checkMailInBase(mail: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataProvider.instance.context.count(for: fetchRequest)
            if count > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    func authorize(mail: String, password: String, complition: @escaping (Result<Void, AuthError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let predicate = NSPredicate(format: "mail == %@ AND password == %@", mail, password)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataProvider.instance.context.count(for: fetchRequest)
            if count > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    complition(.success(()))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    complition(.failure(.loginFailed))
                }
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(.failure(.unknown))
            }
        }
    }
    
}




