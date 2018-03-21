//
//  Entity+CoreDataProperties.swift
//  DataBase Controller
//
//  Created by Appinventiv-Mac on 08/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?

}
