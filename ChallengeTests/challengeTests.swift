//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Michael Steudter on 12.07.22.
//

import XCTest
@testable import Challenge

class ChallengeTests: XCTestCase {

	// TODO: Add tests

	// MARK: - Subject under test
	var sut: ObjectListInteractor!

	override func setUp() {
		super.setUp()
		setupListInteractor()
	}

	func setupListInteractor() {
		sut = ObjectListInteractor()
	}
}
