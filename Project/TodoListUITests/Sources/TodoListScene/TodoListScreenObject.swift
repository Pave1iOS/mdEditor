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

	private lazy var tableView = app.tables.matching(identifier: AccessibilityIdentifier.tableView)
	private lazy var cellDoHomework = tableView.cells.element(
		matching: .cell,
		identifier: AccessibilityIdentifier.cellDoHomework
	)
	private lazy var cellDoWorkout = tableView.cells.element(
		matching: .cell,
		identifier: AccessibilityIdentifier.cellDoWorkout
	)
	private lazy var cellWriteNewTasks = tableView.cells.element(
		matching: .cell,
		identifier: AccessibilityIdentifier.cellWriteNewTasks
	)
	private lazy var cellSolve3algorithms = tableView.cells.element(
		matching: .cell,
		identifier: AccessibilityIdentifier.cellSolve3algorithms
	)
	private lazy var cellGoShopping = tableView.cells.element(
		matching: .cell,
		identifier: AccessibilityIdentifier.cellGoShopping
	)
	
	private var appLanguage = LaunchArguments.Language.english

	// MARK: - ScreenObject Methods

	@discardableResult
	func isTodoListScreen() -> Self {
		assert(cellDoHomework, [.exists])
		assert(cellDoWorkout, [.exists])
		assert(cellWriteNewTasks, [.exists])
		assert(cellSolve3algorithms, [.exists])
		assert(cellGoShopping, [.exists])

		return self
	}
	
	@discardableResult
	func launchApp(inLanguage language: LaunchArguments.Language) -> Self {
		setLanguage(language, app: app)
		launchingApp(app)
		
		return self
	}
	
	@discardableResult
	func displayTaskInformation() -> XCUIElement {

		let taskInformation: String = appLanguage == .russian
		? "Deadline"
		: "Выполнить до"
		
		
		
		return app.tables.staticTexts[taskInformation]
	}
	
	@discardableResult
	func tapDoHomework() -> Self {
		cellDoHomework.tap()

		return self
	}
	
	@discardableResult
	func tapDoWorkout() -> Self {
		cellDoWorkout.tap()
		
		return self
	}
	
	@discardableResult
	func tapWriteNewTasks() -> Self {
		cellWriteNewTasks.tap()
		
		return self
	}
	
	@discardableResult
	func tapSolve3algorithms() -> Self {
		cellSolve3algorithms.tap()
		
		return self
	}
	
	@discardableResult
	func tapGoShopping() -> Self {
		cellGoShopping.tap()
		
		return self
	}
}

private extension TodoListScreenObject {
	/// Смена языка приложения
	func setLanguage(_ language: LaunchArguments.Language, app: XCUIApplication) {
		appLanguage = language
		app.launchArguments += [LaunchArguments.appleLanguages, "(\(language))"]
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
