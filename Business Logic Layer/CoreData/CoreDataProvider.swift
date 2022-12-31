//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData

class CoreDataProvider {
    
    struct Constants {
        static let entity = "Person"
        static let sortName = "mail"
        
    }
    
    enum Response {
        case success
        case fail
    }
    
    enum Error {
        
    }
    
    //    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
    //        let sortDescriptor = NSSortDescriptor(key: Constants.sortName, ascending: true)
    //        fetchRequest.sortDescriptors = [sortDescriptor]
    //        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
    //        return fetchedResultController
    //    }()
    init() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        return fetchRequest
    }()
//    var person: [Person]?
    
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
    
    
    func changePassword(mail:String, password:String , newPassword: String) -> Response {
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.mail == mail && result.password == password {
                    result.password = newPassword
                    CoreDataManager.instance.saveContext()
                    return Response.success
                }
            }
        } catch {
            print(error)
        }
        
        return Response.fail
    }
    
    func checkMailInBase(mail:String) -> Bool {
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.mail == mail {
                    return true
                }
            }
        } catch {
            print(error)
        }
        return false
    }
    
    //    func performFetch() {
    //        do {
    //            try fetchResultController.performFetch()
    //        } catch {
    //            print(error)
    //        }
    //    }
    
    func deleteAllUsers() -> Response{

        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                CoreDataManager.instance.context.delete(result)
                
            }
            CoreDataManager.instance.saveContext()
            return Response.success
        } catch {
            print(error)
        }
        
        return.fail
    }
    
    
    
    func loginCheck(mail:String, password:String) -> Response {

        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.mail == mail && result.password == password {
                    return Response.success
                }
            }
        } catch {
            print(error)
        }
        return Response.fail
    }
    
    
    
    
}




