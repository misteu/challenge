//
//  ManagedObject+CoreDataProperties.swift
//  Challenge
//
//  Created by skrr on 13.07.22.
//
//

import Foundation
import CoreData


extension ManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedObject> {
        return NSFetchRequest<ManagedObject>(entityName: "ManagedObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var userDescription: String?
    @NSManaged public var objects: NSSet?

}

// MARK: Generated accessors for objects
extension ManagedObject {

    @objc(addObjectsObject:)
    @NSManaged public func addToObjects(_ value: ManagedObject)

    @objc(removeObjectsObject:)
    @NSManaged public func removeFromObjects(_ value: ManagedObject)

    @objc(addObjects:)
    @NSManaged public func addToObjects(_ values: NSSet)

    @objc(removeObjects:)
    @NSManaged public func removeFromObjects(_ values: NSSet)

}

extension ManagedObject : Identifiable {

}
