//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData


enum Response {
    case success
    case fail
    case userNotExist
    case userExist
    case connectionFail
    case wrongPassword
    case passwordChanged
}

class CoreDataProvider {
    
    struct Constants {
        static let entity = "Person"
        static let sortName = "mail"
        
    }

    
    init() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        return fetchRequest
    }()
    
    func getAllUsers() -> [Person] {
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            let person = results as! [Person]
            return person
        } catch {
            print(error)
        }
        return []
    }
    
    func addNewUser(email: String, password: String) -> Response {
        let object = Person()
        object.mail = email
        object.password = password
        CoreDataManager.instance.saveContext()
        return Response.success
    }
    
    
    func changePassword(mail: String, password: String, newPassword: String) -> Response {
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            guard let person = results.first as? Person else {
                return .userNotExist
            }
            guard person.password == password else {
                return .wrongPassword
            }
            person.password = newPassword
            CoreDataManager.instance.saveContext()
            return .passwordChanged
        } catch {
            print(error)
        }
        return .connectionFail
    }
    
    func checkMailInBase(mail: String) -> Response {
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataManager.instance.context.count(for: fetchRequest)
            if count > 0 {
                return .userExist
            }
        } catch {
            print(error)
        }
        return .userNotExist
    }
    
    
    func deleteAllUsers() -> Response {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataManager.instance.context.execute(deleteRequest)
            return .success
        } catch {
            print(error)
        }
        return .fail
    }
    
    
    
    func loginCheck(mail: String, password: String) -> Response {
        let predicate = NSPredicate(format: "mail = %@ AND password = %@", mail, password)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataManager.instance.context.count(for: fetchRequest)
            if count > 0 {
                return .success
            }
        } catch {
            print(error)
        }
        return .fail
    }
    
    
    
    
}




