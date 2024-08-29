//
//  TodoListSceneUITest.swift
//  MdEditorUITests
//
//  Created by Kirill Leonov on 02.02.2024.
//  Copyright © 2024 leonovka. All rights reserved.
//

import XCTest

final class TodoListSceneUITest: XCTestCase {

	let app = XCUIApplication()
	lazy var screen = TodoListSceneObject(app: app)

	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app.launchArguments = [LaunchArguments.runTodoListFlow.rawValue]

		app.launch()
	}

	func test_sections_mustBeValid() {
		screen
			.isTodoListScreen()
			.checkSectionsTitle(index: 0, title: L10n.TodoList.Section.uncompleted)
			.checkSectionsTitle(index: 1, title: L10n.TodoList.Section.completed)
	}

	func test_tasks_mustBeValid() {
		screen
			.isTodoListScreen()
			.checkCountOfSelectedItems(1)
			.checkCountOfNotSelectedItems(4)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: L10n.Task.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: L10n.Task.doWorkout)
	}

	func test_doTask_mustBeValid() {
		screen
			.isTodoListScreen()
			.tapOnCell(section: 0, row: 0)
			.checkCountOfSelectedItems(2)
			.checkCountOfNotSelectedItems(3)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 1, row: 1, title: L10n.Task.doWorkout)
	}

	func test_undoTask_mustBeValid() {
		screen
			.isTodoListScreen()
			.tapOnCell(section: 1, row: 0)
			.checkCountOfSelectedItems(0)
			.checkCountOfNotSelectedItems(5)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: L10n.Task.doWorkout)
			.checkCellTitle(section: 0, row: 4, title: L10n.Task.solve3Algorithms)
	}

}
