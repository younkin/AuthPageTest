//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData


struct Response {
    var result: Result
    var token: String?
    
    enum Result {
        case success
        case fail
        case userNotExist
        case userExist
        case connectionFail
        case wrongPassword
        case passwordChanged
    }
}

class CoreDataProvider {
    
    struct Constants {
        static let entity = "Person"
        static let sortName = "mail"
    }
    
    private init() {}
    
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
    
    func addNewUser(email: String, password: String, complition: @escaping (Response) -> Void) {
        if checkMailInBase(mail:email) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(Response(result: .userExist, token: nil))
            }
            return
        }
        
        let object = Person()
        object.mail = email
        object.password = password
        CoreDataManager.instance.saveContext()
        //        let token = UUID().uuidString
        let token = "2ed332edfrssr"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(Response(result: .success, token: token))
        }
        
    }
    
    
    func changePassword(mail: String, password: String, newPassword: String, complition: @escaping (Response) -> Void)
    {
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            guard let person = results.first as? Person else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    complition(Response(result: .userNotExist))
                }
                return
            }
            guard person.password == password else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    complition(Response(result: .wrongPassword))
                }
                return
            }
            person.password = newPassword
            CoreDataManager.instance.saveContext()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(Response(result: .passwordChanged))
            }
            return
        } catch {
            print(error)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(Response(result: .connectionFail))
        }
    }
    
    private func checkMailInBase(mail: String) -> Bool {
        let predicate = NSPredicate(format: "mail = %@", mail)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataManager.instance.context.count(for: fetchRequest)
            if count > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    
    func deleteAllUsers() -> Response {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataManager.instance.context.execute(deleteRequest)
            return Response(result: .success)
        } catch {
            print(error)
        }
        return Response(result: .fail)
    }
    
    
    
    func loginCheck(mail: String, password: String, complition: @escaping (Response) -> Void) {
        let predicate = NSPredicate(format: "mail = %@ AND password = %@", mail, password)
        fetchRequest.predicate = predicate
        do {
            let count = try CoreDataManager.instance.context.count(for: fetchRequest)
            if count > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let token = "2ed332edfrssr"
                    complition(Response(result: .success, token: token))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    complition(Response(result: .fail))
                }
            }
        } catch {
            print(error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                complition(Response(result: .fail))
            }
        }
    }
    
    
    
    
    
}




