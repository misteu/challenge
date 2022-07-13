//
//  CreateAndEditObjectInteractor.swift
//  Challenge
//
//  Created by skrr on 12.07.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateAndEditObjectBusinessLogic {
	func fetchObjectForEditing(request: CreateAndEditObject.FetchObject.Request) async
	func saveObject(request: CreateAndEditObject.CreateObject.Request) async
	func updateObject(request: CreateAndEditObject.UpdateObject.Request) async
	func fetchObject(request: CreateAndEditObject.FetchObject.Request) async -> Object?
	func createObject()
	var objectToEdit: Object? { get }
}

protocol CreateAndEditObjectDataStore {
	//var name: String { get set }
}

class CreateAndEditObjectInteractor: CreateAndEditObjectBusinessLogic, CreateAndEditObjectDataStore {
	var presenter: CreateAndEditObjectPresentationLogic?
	var worker = ObjectWorker(objectsStore: LocalStore())

	var objectToEdit: Object?

	func fetchObjectForEditing(request: CreateAndEditObject.FetchObject.Request) async {
		if let object = await worker.fetchObject(id: request.id) {
			objectToEdit = object
			presenter?.presentObjectEditing(response: CreateAndEditObject.FetchObject.Response(object: object))
		}
	}

	func createObject() {
		let newObject = Object(name: "", description: "", type: "", relations: [])
		presenter?.presentObjectCreating(response: .init(object: newObject))
	}

	func saveObject(request: CreateAndEditObject.CreateObject.Request) async {
		let object = Object(name: request.name, description: request.description, type: request.type, relations: request.relations)
		await worker.createObject(object: object)
	}

	func updateObject(request: CreateAndEditObject.UpdateObject.Request) async {
		let object = Object(name: request.name, description: request.description, type: request.type, id: request.id, relations: request.relations)
		await worker.updateObject(object: object)
	}

	func fetchObject(request: CreateAndEditObject.FetchObject.Request) async -> Object? {
		await worker.fetchObject(id: request.id)
	}
}