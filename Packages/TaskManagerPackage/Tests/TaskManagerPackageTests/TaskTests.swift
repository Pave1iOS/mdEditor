//
//  File.swift
//  

import XCTest
@testable import TaskManagerPackage

final class TaskTests: XCTestCase {

	func test_init_withTitleAndCompleted_shouldHaveCorrect() {
		let sut = Task(title: title, completed: true)

		XCTAssertEqual(sut.title, title, "Не совпадает имя задания с переданным в инициализатор.")
		XCTAssertTrue(sut.completed, "Задание ожидалось создаться выполненным.")
	}

	func test_init_defaultCompleted_propertyCompletedShouldBeFalse() {
		let sut = Task(title: title)

		XCTAssertFalse(sut.completed, "Задание ожидалось создаться невыполненным.")
	}

	func test_init_withTitleNotCompleted_shouldHaveCorrect() {
		let sut = Task(title: title, completed: false)

		XCTAssertEqual(sut.title, title, "Не совпадает имя задания с переданным в инициализатор.")
		XCTAssertFalse(sut.completed, "Задание ожидалось создаться невыполненным.")
	}

	func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
		let sut = Task(title: title, completed: false)
		sut.completed.toggle()

		XCTAssertTrue(sut.completed, "Задание должно было стать выполненным.")
	}
}

// MARK: - TestData

private extension TaskTests {
	var title: String {
		"Test Task"
	}
}
