//
//  ObjectStoreProtocol.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//

import CoreData

// swiftlint:disable identifier_name
protocol ObjectsStoreProtocol {
	func fetchObjects() async throws -> [Object]
	func fetchObject(id: String) async -> Object?
	func createObject(objectToCreate: Object) async
	func updateObject(updatedObject: Object) async
	func deleteObject(id: String) async
}
