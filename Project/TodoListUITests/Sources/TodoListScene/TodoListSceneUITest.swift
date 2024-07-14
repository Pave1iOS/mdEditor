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

	// MARK: - UITest Section Title (completed/uncompleted)
	func test_section_checkSectionTitle() {
		todoListScreen
			.startTodoListScreen()
			.check(sectionTitle: L10n.Section.Title.uncompleted, andSectionNumber: 0)
			.check(sectionTitle: L10n.Section.Title.completed, andSectionNumber: 1)
	}

	// MARK: - UITest Task Information (deadline)
	func test_information_checkTaskInformation() {
		todoListScreen
			.startTodoListScreen()
			.check(cellDescription: L10n.ImportantTask.deadline, row: 0, andSection: 0)
			.check(cellDescription: L10n.ImportantTask.deadline, row: 1, andSection: 0)
			.check(cellDescription: L10n.ImportantTask.deadline, row: 2, andSection: 0)
	}

	// MARK: - UITest Task Completed (task is completed)
	func test_completed_taskIsCompleted() {
		todoListScreen
			.startTodoListScreen()
			.checkCount(completedItems: 1)
			.checkCount(unCompletedItems: 4)
			.tapOn(cell: 1, inSection: 0)
			.checkCount(completedItems: 2)
			.checkCount(unCompletedItems: 3)
			.tapOn(cell: 1, inSection: 1)
			.checkCount(completedItems: 1)
			.checkCount(unCompletedItems: 4)
	}
}
