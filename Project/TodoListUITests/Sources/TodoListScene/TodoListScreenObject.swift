//
//  TodoListScreenObject.swift
//  TodoListUITests
//
//  Created by Pavel Gribachev on 10.07.2024.
//  Copyright © 2024 team.seefood. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var tableView = app.tables[AccessibilityIdentifier.ToDoListScene.tableView.description]
	// MARK: - ScreenObject Methods

	@discardableResult
	func startTodoListScreen() -> Self {
		launchingApp(app)

		return self
	}

	@discardableResult
	func check(sectionTitle title: String, andSection section: Int) -> Self {
		let section = get(section: section)

		XCTAssertEqual(section.label, title)

		return self
	}

	@discardableResult
	func check(cellTitle title: String, row: Int, andSection section: Int) -> Self {
		let cell = get(cellRow: row, andSection: section)
		assert(cell, [.exists])

		let titleCell = cell.staticTexts.element(boundBy: 0).label

		XCTAssertTrue(titleCell.contains(title))

		return self
	}

	@discardableResult
	func check(cellDescription description: String, row: Int, andSection section: Int) -> Self {

		let cell = get(cellRow: row, andSection: section)
		assert(cell, [.exists])

		let descriptionCell = cell.staticTexts.element(boundBy: 1).label

		XCTAssertTrue(descriptionCell.contains(description))

		return self
	}

	@discardableResult
	func tapOn(cell: Int, inSection section: Int) -> Self {
		let cell = get(cellRow: cell, andSection: section)

		assert(cell, [.exists])

		cell.tap()

		return self
	}

	@discardableResult
	func checkCount(selectedItems count: Int) -> Self {
		assert(tableView, [.exists])

		let selected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { $0.isSelected }

		XCTAssertEqual(selected.count, count)

		return self
	}

	@discardableResult
	func checkCount(unSelectedItems count: Int) -> Self {
		assert(tableView, [.exists])

		let unSelected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { !$0.isSelected }

		XCTAssertEqual(unSelected.count, count)

		return self
	}
}
private extension TodoListScreenObject {

	func get(cellRow row: Int, andSection section: Int) -> XCUIElement {
		tableView.cells[AccessibilityIdentifier.ToDoListScene.cell(row: row, section: section).description]
	}

	func get(section: Int) -> XCUIElement {
		tableView.otherElements[AccessibilityIdentifier.ToDoListScene.section(section).description]
	}

	/// Запуск приложения с главной сцены
	func launchingApp(_ app: XCUIApplication) {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()

		loginScreen
			.login()

		//		loginScreen
		//			.isLoginScreen()
		//			.set(login: "Admin")
		//			.set(password: "Pass")
		//			.login()
	}
}
