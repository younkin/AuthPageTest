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
public final class Person: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataProvider.instance.entityForName(entityName: "Person"), insertInto: CoreDataProvider.instance.context)
    }

}
