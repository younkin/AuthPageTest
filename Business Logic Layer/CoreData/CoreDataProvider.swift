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
    
//    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
//        let sortDescriptor = NSSortDescriptor(key: Constants.sortName, ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
//        return fetchedResultController
//    }()
    
    init() {
    
//        performFetch()
        // извлекаем данные
        
     

//        if checkMailInBase(mail: "admin") {
//            print(loginCheck(mail: "admin", password: "adminChanged"))
//        } else {
//            print("зарегистрируйся")
//        }
        

//        print(changePassword(mail: "admin", password: "admin", newPassword: "adminChanged"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
    func getAllUsers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("mail - \(result.mail), password \(result.password)")
            }
            
        } catch {
            print(error)
        }
    }
    
    
    func changePassword(mail:String, password:String , newPassword: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.mail == mail && result.password == password {
                    result.password = newPassword
                    CoreDataManager.instance.saveContext()
                    return true
                }
            }
        } catch {
            print(error)
        }
      
        return false
    }
    
    func checkMailInBase(mail:String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
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
    
    func addNewUser(email: String, password: String) {
        let manageObject = Person()
        manageObject.mail = email
        manageObject.password = password
        CoreDataManager.instance.saveContext()
        
    }
    
    
    func deleteAllUsers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
                   let results = try CoreDataManager.instance.context.fetch(fetchRequest)
                   for result in results as! [NSManagedObject] {
                       CoreDataManager.instance.context.delete(result)
                   }
               } catch {
                       print(error)
                   }
               CoreDataManager.instance.saveContext()
    }
    
    
    
    func loginCheck(mail:String, password:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.mail == mail && result.password == password {
                    return true
                } else {return false}
            }
        } catch {
            print(error)
            return false
        }
        return false
    }
   
    
    
    
    }




