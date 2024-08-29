//
//  LoginScreenObject.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 05.04.2023.
//

import XCTest

final class LoginScreenObject: BaseScreenObject {
	
	// MARK: - Private properties
	
	lazy var textFieldLogin = app.textFields[AccessibilityIdentifier.LoginScene.textFieldLogin.description]
	lazy var textFieldPass = app.secureTextFields[AccessibilityIdentifier.LoginScene.textFieldPass.description]
	lazy var loginButton = app.buttons[AccessibilityIdentifier.LoginScene.buttonLogin.description]
	
	// MARK: - Public methods

	// Проверка элементов экрана
	@discardableResult
	func isLoginScreen() -> Self {
		checkTitleForRightText(contains: L10n.Login.title)
		assert(textFieldLogin, [.exists])
		assert(textFieldPass, [.exists])
		assert(loginButton, [.exists])
		
		return self
	}

	@discardableResult
	func isNotLoginScreen() -> Self {
		assert(textFieldLogin, [.doesNotExist])
		assert(textFieldPass, [.doesNotExist])
		assert(loginButton, [.doesNotExist])

		return self
	}
	
	@discardableResult
	func set(login: String) -> Self {
		assert(textFieldLogin, [.exists])
		textFieldLogin.tap()
		textFieldLogin.typeText(login)
		
		return self
	}
	
	@discardableResult
	func set(password: String) -> Self {
		assert(textFieldPass, [.exists])
		textFieldPass.tap()
		textFieldPass.typeText(password)
		
		return self
	}
	
	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()
		
		return self
	}
}
