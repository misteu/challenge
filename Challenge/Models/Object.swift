//
//  Object.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//

import Foundation
// swiftlint:disable identifier_name

/// Model of an `Object` that can be represented in a data store and in the UI.
/// An object can have relations to _many_ other objects.
/// Represented by `ManagedObject` in CoreData store.
struct Object {
	/// The object's name
	var name: String
	/// The object's description
	var description: String
	/// The object's type.
	var type: String
	/// The object's optional id for identifying it in the store.
	var id: String?
	/// The object's relations (Ids of related objects).
	var relations: Set<String>
}
