//
//  ObjectListPresenter.swift
//  challenge
//
//  Created by Michael Steudter on 12.07.22.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Conforming classes can present a list of objects.
protocol ObjectListPresentationLogic {
	/// Presents screen with list of objects for navigating to their edit screens.
	func presentObjectList(response: ListObjects.FetchObjects.Response)
	/// Presents screen with list of objects for selecting object relations.
	func presentObjectRelationList(response: ListObjects.RelationSelector.Response)
}

final class ObjectListPresenter: ObjectListPresentationLogic {
	/// The source view controller.
	weak var viewController: ObjectListDisplayLogic?

	// MARK: - ObjectListPresentationLogic

	func presentObjectList(response: ListObjects.FetchObjects.Response) {
		let displayedObjects = response.objects.map {
			ListObjects.DisplayedObject(
				type: $0.type,
				name: $0.name,
				description: $0.description,
				id: $0.id
			)
		}
		let viewModel = ListObjects.FetchObjects.ViewModel(displayedObjects: displayedObjects)
		viewController?.displayFetchedObjects(viewModel: viewModel)
	}

	func presentObjectRelationList(response: ListObjects.RelationSelector.Response) {
		let displayedObjects = response.objects.map {
			ListObjects.DisplayedObject(
				type: $0.type,
				name: $0.name,
				description: $0.description,
				id: $0.id
			)
		}
		let viewModel = ListObjects.RelationSelector.ViewModel(displayedObjects: displayedObjects)
		viewController?.displayObjectRelationSelector(viewModel: viewModel)
	}
}
