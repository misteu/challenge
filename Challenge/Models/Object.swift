//
//  Object.swift
//  Challenge
//
//  Created by Michael Steudter on 12.07.22.
//

import Foundation
// swiftlint:disable identifier_name
struct Object {
	var name: String
	var description: String
	var type: String
	var id: String?
	var relations: Set<String>
}
