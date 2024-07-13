//
//  TodoListSceneUITest.swift
//  TodoListUITests
//
//  Created by Pavel Gribachev on 10.07.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import XCTest

final class TodoListSceneUITest: XCTestCase {

	var app: XCUIApplication!
	var todoListScreen: TodoListScreenObject!

	override func setUp() {
		super.setUp()

		app = XCUIApplication()
		todoListScreen = TodoListScreenObject(app: app)
	}

	override func tearDown() {
		let screenshot = XCUIScreen.main.screenshot()
		let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
		fullScreenshotAttachment.name = "Fail test"
		fullScreenshotAttachment.lifetime = .deleteOnSuccess
		add(fullScreenshotAttachment)
		// Closing the app
		//		app.terminate()
	}

	// MARK: - UITest Section

	func test_section_sectionTitle() {
		todoListScreen
			.startTodoListScreen()
			.check(sectionTitle: L10n.Section.Title.uncompleted.description, andSection: 0)
	}
}
