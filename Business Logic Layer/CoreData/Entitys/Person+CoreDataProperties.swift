//
//  Person+CoreDataProperties.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var mail: String?
    @NSManaged public var password: String?

}

extension Person : Identifiable {

}
