//
//  CreateAndEditObjectInteractor.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Defines CRUD methods for handling objects on a store.
protocol CreateAndEditObjectBusinessLogic {
	/// Fetches object for editing (properties and relations)
	func fetchObjectForEditing(request: CreateAndEditObject.FetchObject.Request) async
	/// Presents object creation screen.
	func createObject()
	/// Saves object to store.
	func saveObject(request: CreateAndEditObject.CreateObject.Request) async
	/// Updates stored object with given request.
	func updateObject(request: CreateAndEditObject.UpdateObject.Request) async
	/// Fetches object.
	/// - Returns: An `Object` created from store.
	func fetchObject(request: CreateAndEditObject.FetchObject.Request) async -> Object?
	/// The edited object.
	var objectToEdit: Object? { get }
}

final class CreateAndEditObjectInteractor: CreateAndEditObjectBusinessLogic {
	var presenter: CreateAndEditObjectPresentationLogic?
	/// Worker interacting with `LocalStore` (CoreData).
	var worker = ObjectWorker(objectsStore: LocalStore())
	var objectToEdit: Object?

	func fetchObjectForEditing(request: CreateAndEditObject.FetchObject.Request) async {
		if let object = await worker.fetchObject(id: request.id) {
			objectToEdit = object
			Task {
				await presenter?.presentObjectEditing(response: CreateAndEditObject.FetchObject.Response(object: object))
			}
		}
	}

	func createObject() {
		let newObject = Object(name: "", description: "", type: "", relations: [])
		Task {
			await presenter?.presentObjectCreating(response: .init(object: newObject))
		}
	}

	func saveObject(request: CreateAndEditObject.CreateObject.Request) async {
		let object = Object(name: request.name,
							description: request.description,
							type: request.type,
							relations: request.relations)
		await worker.createObject(object: object)
	}

	func updateObject(request: CreateAndEditObject.UpdateObject.Request) async {
		let object = Object(name: request.name,
							description: request.description,
							type: request.type,
							id: request.id,
							relations: request.relations)
		await worker.updateObject(object: object)
	}

	func fetchObject(request: CreateAndEditObject.FetchObject.Request) async -> Object? {
		await worker.fetchObject(id: request.id)
	}
}
