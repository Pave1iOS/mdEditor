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
