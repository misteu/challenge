//
//  LocalStore.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//

import UIKit
import CoreData

// swiftlint:disable identifier_name

/// Handles CRUD operations on CoreData storage.
class LocalStore: ObjectsStoreProtocol {

	@MainActor
	/// The context used for data manipulation as set in `AppDelegate`.
	private var context: NSManagedObjectContext? {
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		return appDelegate?.persistentContainer.viewContext
	}

	func fetchObjects() async throws -> [Object] {
		var retVal: [Object] = []
		let objectFetchRequest: NSFetchRequest<ManagedObject> = ManagedObject.fetchRequest()

		if let results = try await context?.fetch(objectFetchRequest) {
			if results.count > 0 {
				results.forEach {

					var relations: Set<String> = []
					$0.objects?.forEach { relation in
						if let id = (relation as? ManagedObject)?.objectID.uriRepresentation().absoluteString {
							relations.insert(id)
						}
					}
					retVal.append(.init(
						name: $0.name ?? "",
						description: $0.userDescription ?? "",
						type: $0.type ?? "",
						id: $0.objectID.uriRepresentation().absoluteString,
						relations: relations)
					)
				}
			}
		}
		return retVal
	}

	func fetchObject(id: String) async -> Object? {
		var retVal: Object?
		let managedObject = await loadObject(id: id)
		var relations: Set<String> = []

		managedObject?.objects?.forEach { relation in
			if let id = (relation as? ManagedObject)?.objectID.uriRepresentation().absoluteString {
				relations.insert(id)
			}
		}
		retVal = .init(name: managedObject?.name ?? "",
					   description: managedObject?.userDescription ?? "",
					   type: managedObject?.type ?? "",
					   id: managedObject?.objectID.uriRepresentation().absoluteString,
					   relations: relations)
		return retVal
	}

	func createObject(objectToCreate: Object) async {
		// create new object in cd
		if let context = await context {
			let object = ManagedObject(context: context)
			object.type = objectToCreate.type
			object.name = objectToCreate.name
			object.userDescription = objectToCreate.description
			await save()
		}
	}

	func updateObject(updatedObject: Object) async {
		if let id = updatedObject.id,
		   let object = await loadObject(id: id) {
			object.type = updatedObject.type
			object.name = updatedObject.name
			object.userDescription = updatedObject.description
			let relatedObjects: NSMutableSet = []
			for relation in updatedObject.relations {
				let object = await loadObject(id: relation) as Any
				relatedObjects.add(object)
			}
			object.objects = relatedObjects
			await save()
		}
	}

	func deleteObject(id: String) async {
		if let object = await loadObject(id: id) {
			await context?.delete(object)
			await save()
		}

	}

}

// MARK: - Helper

extension LocalStore {
	@MainActor
	func loadObject(id: String) -> ManagedObject? {
		guard let url = URL(string: id),
			  let objectId = context?
				.persistentStoreCoordinator?
				.managedObjectID(forURIRepresentation: url) else { return nil }

		let objectForId = context?.object(with: objectId)
		if objectForId?.isFault == false {
			return objectForId as? ManagedObject
		}

		let request = NSFetchRequest<NSFetchRequestResult>()
		request.entity = objectId.entity
		let predicate = NSComparisonPredicate(leftExpression: .expressionForEvaluatedObject(),
											  rightExpression: .init(forConstantValue: objectForId),
											  modifier: .direct,
											  type: .equalTo,
											  options: .caseInsensitive)
		request.predicate = predicate
		if let results = try? context?.fetch(request),
		   results.count > 0 {
			return results.first as? ManagedObject
		}
		return nil
	}

	@MainActor
	func save() {
		do {
			try context?.save()
		} catch {
			fatalError("error saving \(error)")
		}
	}
}
