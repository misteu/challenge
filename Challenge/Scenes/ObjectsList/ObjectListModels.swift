//
//  ObjectListModels.swift
//  challenge
//
//  Created by Michael Steudter on 12.07.22.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
// swiftlint:disable nesting

enum ListObjects {

	struct DisplayedObject {
		var type: String
		var name: String
		var description: String
		var id: String?
	}

	enum FetchObjects {
		struct Request { }
		struct Response {
			var objects: [Object]
		}
		struct ViewModel {

			var displayedObjects: [DisplayedObject]
			static let title = "Objects"
		}
	}

	enum RelationSelector {
		struct Request {
			var object: Object?
		}
		struct Response {
			var objects: [Object]
		}
		struct ViewModel {

			var displayedObjects: [DisplayedObject]
			static let title = "Add Relation"
		}
	}

	enum DeleteObject {
		struct Request {
			var id: String
		}
		struct Response { }
		struct ViewModel { }
	}
}