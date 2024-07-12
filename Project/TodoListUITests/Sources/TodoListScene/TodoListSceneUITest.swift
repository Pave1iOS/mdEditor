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
	func test_sectionHeader_correctHeaderEN() {
		todoListScreen
			.launchApp(inLanguage: .english)
		
		XCTAssertTrue(app.tables.staticTexts["Uncompleted"].exists, "Section Header 1 not found in English")
		XCTAssertTrue(app.tables.staticTexts["Completed"].exists, "Section Header 2 not found in English")
	}

	func test_sectionHeader_correctHeaderRU() {
		todoListScreen
			.launchApp(inLanguage: .russian)
		
		XCTAssertTrue(app.tables.staticTexts["Не выполненные"].exists, "Секция 1 не найдена на Русском")
		XCTAssertTrue(app.tables.staticTexts["Выполненные"].exists, "Секция 2 не найдена на Русском")
	}
	
	// MARK: - Task Description
	
	func test_taskInformation_displayRU() {
		
		todoListScreen
			.launchApp(inLanguage: .russian)
		
		let date = dateFormat(getDate())
		let result = app.tables.staticTexts["Выполнить до: \(date)"]
		
		XCTAssertTrue(result.exists)
	}
	
	private func getDate() -> Date {
		Calendar.current.date(byAdding: .day, value: 2, to: Date())!
	}
	
	private func dateFormat(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, d MMM"
		return formatter.string(from: date)
	}
	
	// MARK: Completed Task
	
	func test_completedTask_swipeToSection() {
		
	}
	
	
	


	
//	func test_sectionHeader_correctHeaderRU() {
//		setLanguage("ru")
//		let aaa = ""
//		XCTAssertTrue(app.tables.staticTexts["Не выполненые"].exists, "Section Header 1 not found in English")
//		XCTAssertTrue(app.tables.staticTexts["Выполненые"].exists, "Section Header 2 not found in English")
//	}
//	
//	

	
//	private func setLanguage(_ language: String) {
//		app.launchArguments += ["-AppleLanguages", "(\(language))"]
//	}
	
//	func test() {
//		
//		let app = XCUIApplication()
//		app.buttons["LoginViewController.buttonLogin"].tap()
//
//		let todolistviewcontrollerTableviewTable = app.tables["TodoListViewController.tableView"]
//		let staticText = todolistviewcontrollerTableviewTable.staticTexts["Не выполненные"]
//		staticText.tap()
//		
//		let staticText2 = todolistviewcontrollerTableviewTable.staticTexts["Выполненные"]
//		staticText2.tap()
//		staticText2.tap()
//		staticText.tap()
//		staticText2.tap()
//		
//	}

//	func test() {
//		todoListScreen.tapDoHomework()
//		sleep(2)
//	}
//	
//	func test_tap_selectDoHomework() {
//		let cell = app.tables.cells.element(matching: .cell, identifier: AccessibilityIdentifier.cellDoHomework)
//		cell.tap()
//		sleep(2)
//		
//		let cellText = ""
//		let actualText = cell.staticTexts.firstMatch.label
//		XCTAssertEqual(actualText, cellText, "Текст в ячейке не соответствует ожидаемому")
//		
//	}
//	
//	func test1_sectionHeaders_correspondenceTitle() {
//		let cell1 = app.tables.cells.element(boundBy: 0)
//		cell1.tap()
//		sleep(1)
//		let cell2 = app.tables.cells.element(boundBy: 1)
//		cell1.tap()
//		sleep(1)
//		let cell3 = app.tables.cells.element(boundBy: 2)
//		cell1.tap()
//		sleep(1)
//		let cell4 = app.tables.cells.element(boundBy: 3)
//		cell1.tap()
//		sleep(1)
//		let cell5 = app.tables.cells.element(boundBy: 4)
//		cell1.tap()
//	}


}
