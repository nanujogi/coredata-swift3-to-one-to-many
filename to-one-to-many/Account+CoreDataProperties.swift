//
//  Account+CoreDataProperties.swift
//  to-one-to-many
//
//  Created by Nanu Jogi on 18/08/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var department: String?
    @NSManaged public var users: NSOrderedSet?

}

// MARK: Generated accessors for users
extension Account {

    @objc(insertObject:inUsersAtIndex:)
    @NSManaged public func insertIntoUsers(_ value: User, at idx: Int)

    @objc(removeObjectFromUsersAtIndex:)
    @NSManaged public func removeFromUsers(at idx: Int)

    @objc(insertUsers:atIndexes:)
    @NSManaged public func insertIntoUsers(_ values: [User], at indexes: NSIndexSet)

    @objc(removeUsersAtIndexes:)
    @NSManaged public func removeFromUsers(at indexes: NSIndexSet)

    @objc(replaceObjectInUsersAtIndex:withObject:)
    @NSManaged public func replaceUsers(at idx: Int, with value: User)

    @objc(replaceUsersAtIndexes:withUsers:)
    @NSManaged public func replaceUsers(at indexes: NSIndexSet, with values: [User])

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSOrderedSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSOrderedSet)

}
