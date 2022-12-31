//
//  Person+CoreDataClass.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
    }

}
