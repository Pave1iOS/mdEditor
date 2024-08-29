//
//  BaseScreenObject.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 05.04.2023.
//

import XCTest

class BaseScreenObject {
	
	// MARK: - Dependencies
	
	let app: XCUIApplication

	// MARK: - Private properties
	
	private static let defaultTimeout: TimeInterval = 5

	// MARK: - Private elements

	private lazy var alert = app.alerts.firstMatch
	private lazy var alertButton = alert.buttons.firstMatch

	private lazy var navigationBar = app.navigationBars.firstMatch
	private lazy var navigationBarButton = navigationBar.buttons.firstMatch
	private lazy var navigationBarTitle = navigationBar.staticTexts.firstMatch
	
	// MARK: - Initialization
	
	init(app: XCUIApplication) {
		self.app = app
	}
	
	// MARK: - ScreenObject Methods
	
	@discardableResult
	func assert(_ element: XCUIElement, _ predicates: [Predicate], timeout: TimeInterval = defaultTimeout) -> Self {
		let expectation = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: predicates.map { $0.format }.joined(separator: " AND ")),
			object: element
		)
		
		guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
			XCTFail("[\(self)] Элемент \(element.description) не соответствует ожиданию: \(predicates.map { $0.format })")
			return self
		}
		return self
	}
	
	@discardableResult
	
	func tap(_ element: XCUIElement, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		assert(element, [.isHittable], timeout: timeout)
		element.tap()
		
		return self
	}
	
	@discardableResult
	func back(timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		tap(navigationBarButton, timeout: timeout)
		
		return self
	}

	@discardableResult
	func checkAlert(title: String, text: String, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		let alertTitle = alert.staticTexts.element(boundBy: 0)
		let alertDescription = alert.staticTexts.element(boundBy: 1)
		assert(alertTitle, [.contains(title)], timeout: timeout)
		assert(alertDescription, [.contains(text)], timeout: timeout)

		return self
	}

	@discardableResult
	func checkAlert(containsText text: String, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		let alertTitle = alert.staticTexts.element(boundBy: 0)
		assert(alertTitle, [.contains(text)], timeout: timeout)

		return self
	}

	@discardableResult
	func closeAlert(timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		assert(alert, [.exists])
		tap(alertButton)
		assert(alert, [.doesNotExist])

		return self
	}

	@discardableResult
	func buttonAlertTap(text: String, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		assert(alert, [.exists])
		alert.buttons[text].tap()

		return self
	}

	@discardableResult
	func checkTitleForRightText(contains text: String, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		assert(navigationBar, [.exists], timeout: timeout)
		assert(navigationBarTitle, [.contains(text)], timeout: timeout)

		return self
	}

	@discardableResult
	func checkTitleForWrongText(contains text: String, timeout: TimeInterval = BaseScreenObject.defaultTimeout) -> Self {
		assert(navigationBar, [.exists], timeout: timeout)
		assert(navigationBarTitle, [.doesNotContain(text)], timeout: timeout)

		return self
	}
}

// MARK: - Keyboard

/// Управление клавиатурой
extension BaseScreenObject {
	enum Lang: String {
		case eng = "English (US)"
		case rus = "Русская"
		case emoji = "Emoji"
	}

	@discardableResult
	func setKeyboard(language: Lang)  -> Self {
		app.buttons["Next keyboard"].press(forDuration: 0.5)
		app.tables["InputSwitcherTable"].staticTexts[language.rawValue].tap()

		return self
	}
}
