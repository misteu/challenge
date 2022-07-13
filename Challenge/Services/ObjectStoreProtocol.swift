//
//  ObjectStoreProtocol.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//

import CoreData

// swiftlint:disable identifier_name
protocol ObjectsStoreProtocol {
	/// Fetches all saved objects.
	/// - Returns: Array of `Object` saved in the store.
	func fetchObjects() async throws -> [Object]
	/// Fetches an object with a given `id`.
	/// - Returns: The `Object` that is identified with the given id.
	func fetchObject(id: String) async -> Object?
	/// Stores the passed `Object` into the store.
	func createObject(objectToCreate: Object) async
	/// Updates the passed `Object` in the store (identified by its `id`)
	func updateObject(updatedObject: Object) async
	/// Deletes objects with given  `id`.
	func deleteObject(id: String) async
}
