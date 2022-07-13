//
//  ObjectStoreProtocol.swift
//  Challenge
//
//  Created by skrr on 12.07.22.
//

import CoreData

protocol ObjectsStoreProtocol {
	func fetchObjects() async throws -> [Object]
	func fetchObject(id: String) async -> Object?
	func createObject(objectToCreate: Object) async
	func updateObject(updatedObject: Object) async
	func deleteObject(id: String) async
}
