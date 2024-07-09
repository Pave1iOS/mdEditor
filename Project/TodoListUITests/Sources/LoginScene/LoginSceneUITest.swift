//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	override func tearDown() {
		// Taking screenshot after test
		let screenshot = XCUIScreen.main.screenshot()
		let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
		fullScreenshotAttachment.name = "Fail test"
		fullScreenshotAttachment.lifetime = .deleteOnSuccess
		add(fullScreenshotAttachment)
		// Closing the app
//		app.terminate()
	}

	// Решение в лоб. Самое быстрое, с использованием записи автотестов, но самое уродливое.
//	func test_login_withValidCred_mustBeSuccess() {
//		let app = XCUIApplication()
//		app.launch()
//
//		let element = app
//			.children(matching: .window)
//			.element(boundBy: 0)
//			.children(matching: .other)
//			.element
//			.children(matching: .other)
//			.element
//			.children(matching: .other)
//			.element
//			.children(matching: .other)
//			.element
//			.children(matching: .other)
//			.element
//			.children(matching: .other)
//			.element
//
//		let textFieldLogin = element
//			.children(matching: .textField)
//			.element(boundBy: 0)
//
//		let textFieldPass = element
//			.children(matching: .textField)
//			.element(boundBy: 1)
//
//		textFieldLogin.tap()
//		textFieldLogin.typeText("Admin")
//
//		textFieldPass.tap()
//		textFieldPass.typeText("Pass")
//
//		app.buttons["Логин"].tap()
//	}

	// Оптимизация автотестов с самостоятельным поиском элементов, основанных на AccessibilityIdentifier.
	// Уже намного лучше, но много повторяющегося кода, трудно читать, долго и много писать.
	// Из-за отсутствия переиспользования элементов, возможны ошибки и увеличение времени выполнения тестов.
//	func test2_login_withValidCred_mustBeSuccess() {
//		let app = XCUIApplication()
//		app.launch()
//
//		let textFieldLogin = app.textFields[AccessibilityIdentifier.textFieldLogin.description]
//		let textFieldPass = app.textFields[AccessibilityIdentifier.textFieldPass.description]
//
//		let button = app.buttons[AccessibilityIdentifier.buttonLogin.description]
//
//		textFieldLogin.tap()
//		textFieldLogin.typeText("Admin")
//
//		textFieldPass.tap()
//		textFieldPass.typeText("pa$$32!")
//
//		button.tap()
//	}

	// Тесты на основе ScreenObject. Самая краткая и удобочитаемая версия тестов.
	// Основное взаимодействие с поиском элементов вынесено в ScreenObject, в тестах только тестирование.
	func test3_login_withValidCred_mustBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)
		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "Pass")
			.login()
	}
}
