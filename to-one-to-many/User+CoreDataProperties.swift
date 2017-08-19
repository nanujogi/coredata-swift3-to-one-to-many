//
//  User+CoreDataProperties.swift
//  to-one-to-many
//
//  Created by Nanu Jogi on 18/08/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var account: Account?

}
