//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
	let app = XCUIApplication()
	lazy var loginScreen = LoginScreenObject(app: app)

	override func setUp() {
		super.setUp()
		app.launch()
	}

	// Тесты на основе ScreenObject. Самая краткая и удобочитаемая версия тестов.
	// Основное взаимодействие с поиском элементов вынесено в ScreenObject, в тестах только тестирование.
	func test3_login_withValidCred_mustBeSuccess() {

		loginScreen
			.isLoginScreen()
			.set(login: TestsString.ValidLoginAndPassword.login)
			.set(password: TestsString.ValidLoginAndPassword.password)
			.login()
	}

	func test_login_with_InvalidCred_mustBeSuccess() {
		loginScreen
			.isLoginScreen()
			.set(login: TestsString.InvalisLoginAndPassword.login)
			.set(password: TestsString.InvalisLoginAndPassword.password)
			.login()
			.checkAlertAndClose()
			.isLoginScreen()
	}
}
