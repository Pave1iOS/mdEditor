//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {

	let app = XCUIApplication()
	lazy var screen = LoginScreenObject(app: app)

	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app.launchArguments = [LaunchArguments.enableTesting.rawValue]

		app.launch()
	}

	func test_login_withInvalidCredentials_mustBeSuccess() {
		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.InvalidCredentials.login)
			.set(password: ConfigureTestEnvironment.InvalidCredentials.password)
			.login()
			.closeAlert()
			.isLoginScreen()
	}

	func test_login_withValidCredentials_mustBeSuccess() {
		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.ValidCredentials.login)
			.set(password: ConfigureTestEnvironment.ValidCredentials.password)
			.login()
			.isNotLoginScreen()
	}
}
