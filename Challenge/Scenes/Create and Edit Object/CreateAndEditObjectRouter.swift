//
//  CreateAndEditObjectRouter.swift
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

// swiftlint:disable identifier_name
@objc protocol CreateAndEditObjectRoutingLogic {
	func routeToObjectList()
	func routeToRelationsSelector(for id: String) async
}

class CreateAndEditObjectRouter: NSObject, CreateAndEditObjectRoutingLogic {

	weak var viewController: CreateAndEditObjectViewController?

	func routeToObjectList() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	@MainActor
	func routeToRelationsSelector(for id: String) async {
		let relationSelector = ObjectListViewController()
		var interactor = relationSelector.interactor
		interactor?.selectedObjectId = id
		await interactor?.listObjectSelector()
		viewController?.navigationController?.pushViewController(relationSelector, animated: true)
	}
}
