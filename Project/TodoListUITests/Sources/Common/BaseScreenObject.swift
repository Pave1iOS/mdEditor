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

	private static let defaultTimeout: TimeInterval = 2

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
}

// MARK: - Keyboard

/// Управление клавиатурой
extension BaseScreenObject {
	enum Lang: String {
		case eng = "English (US)"
		case rus = "Русская"
		case emoji = "Emoji"
	}

	func setKeyboard(language: Lang) {
		app.buttons["Next keyboard"].press(forDuration: 0.5)
		app.tables["InputSwitcherTable"].staticTexts[language.rawValue].tap()
	}
}
